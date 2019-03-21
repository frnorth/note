# Registry
1) registry文档: docs.docker.com --> product manuals --> 左边open-source projects --> docker registry  
2) docker-compose文档: docs.docker.com --> product manuals --> 左边docker compose  
  - 也可以到github上下载安装 --> 连接Compose repository release page on GitHub --> https://github.com/docker/compose/releases 最下面有直接的包下载?  

## CentOS
1) 用openssl生成证书前, 要先修改/etc/pki/tls/openssl.cnf, [v3_ca]下面添加IP, 不然会报错 "...IP SANs...", 而且貌似只能写一个IP, 如果写两个, 就以第2个为准, 而且这个会写到证书里, 如果如与登陆的不一样, 会报不一致的错误。如果是生成域名的证书, 就在[ v3_req ]下面加上subjectAltName = @alt_names, 然后在最下面加上[ alt_names ] 回车 DNS = docker.my.com, 在用openssl生成的时候, Common Name (eg, your name or your servers hostname) []:docker.my.com, 要输入想要的域名.  
2) /etc/docker/certs.d/下面还是要建个192.168.1.127目录(好像也不用建目录), 然后把domain.crt放到里面, 不然docker login后会报错Error response from daemon: Get https://192.168.1.127/v1/users/: x509: certificate signed by unknown authority。  
3) domain.crt 要放到/etc/pki/ca-trust/source/anchors/ 下面, 不然curl会报一段错。Trust the certificate at the OS level.  
4) 2)和3)在别的客户端也要做。  
5) docker-compose.yml中, REGISTRY_HTTP_ADDR: 0.0.0.0:443 # 没有这个会报错: 拒绝连接 (容器内没有监听地址), 而配置文件任意内容写错, 都会导致容器启动不对, 哪怕本地有443端口开启。哈哈, 是这样, 如果在/etc/docker/daemon.json中加了insecure--registries ...:1234, 那么当用http访问1234端口是可以的, 访问别的端口就还是https, 没有证书就是不可以的。
```
]# docker pull registry:2  
]# mkdir /root/docker
]# cd /root/docker
]# vim /etc/pki/tls/openssl.cnf
    [ v3_ca ]
    # Extensions for a typical CA
    subjectAltName = IP:192.168.1.127
或
    [ v3_req ]
    subjectAltName = @alt_names
    ...
    [ alt_names ]
    DNS = docker.my.com
]# mkdir certs  
]# openssl req -newkey rsa:4096 -nodes -sha256 -keyout certs/domain.key -x509 -days 365 -out certs/domain.crt  
    ...
    Common Name (eg, your name or your servers hostname) []:docker.my.com
    ...
]# mkdir auth
]# docker run --entrypoint htpasswd registry:2 -Bbn admin 123456 > auth/htpasswd
]# mkdir data
]# vim docker-compose.yml
    registry:
      restart: always
      image: registry:2
      ports:
        - 443:443
      environment:
        REGISTRY_HTTP_ADDR: 0.0.0.0:443 # 没有这个会报错: 拒绝连接 (容器内没有监听地址)
        REGISTRY_HTTP_TLS_CERTIFICATE: /certs/domain.crt
        REGISTRY_HTTP_TLS_KEY: /certs/domain.key
        REGISTRY_AUTH: htpasswd
        REGISTRY_AUTH_HTPASSWD_PATH: /auth/htpasswd
        REGISTRY_AUTH_HTPASSWD_REALM: Registry Realm
      volumes:
        - /root/docker/data:/var/lib/registry
        - /root/docker/certs:/certs
        - /root/docker/auth:/auth
]# docker-compose up -d
]# mkdir -p /etc/docker/certs.d/192.168.1.127
]# cp certs/domain.crt /etc/docker/certs.d/192.168.1.127/
]# cp certs/domain.crt /etc/pki/ca-trust/source/anchors/domain.crt
]# update-ca-trust
]# systemctl restart docker
```
```
curl -u admin:123456 https://192.168.1.127/v2/
docker login https://192.168.1.127
```

## Ubuntu
1) openssl.cnf 在/etc/ssl/openssl.cnf  
2) 系统级别的(让curl不会报错), domain.crt要放在在/usr/local/share/ca-certificates/下, trust the certificate at the OS level --> update-ca-certificates  

## addition
1) 这个有啥用?
```
]# vim /etc/docker/daemon.json
    {
      "allow-nondistributable-artifacts": ["192.168.1.127:443"]
    }
```
2) config.yml 有啥用?  
3) 官方文档上, Deploy a registry server, 既然搭https, 为啥还要开5000? 不开443?  
4) 貌似正规点的做法是nginx(https)+registry:5000(http)  
5) DTR 跟 registry比怎么样?官网 --> Product Manuals --> Docker Enterprise Edition --> Docker Trusted Registry    
6) 用阿里的"registry-mirrors": ["https://nv2ni2pp.mirror.aliyuncs.com"] 作为proxy貌似不用用户名和密码,,, registry-1.docker.io是要用的, 密码输错会报错。
7) 然而做了缓存后(proxy), 好像pull, push的请求都是通过proxy发往registry-1.dockr.io的, 怎么让push发到本地? 而且pull完, 本地有了之后, 别的机器从本地的registry pull那个下载好的镜像, 好像还是会被转发到registry-1.docker.io!? curl 看_catalog的请求也被转发到远端了, 根本没有去看本地的_catalog..?  
```
实验1: 用442端口上传buxybox:1111111 --> 用curl在443端口上看不到这个1111111
实验2: 接着实验1, 把网掐了 --> 用curl在443端口上看, 能看到111111了...!
实验3: 联网, 从443端口上, dockers pull 11111111 能pull下来, 应该是先找了一圈registry-1.docker.io, 然后发现没有这个tag, 然后又从本地找了。(话说)怎么知道是从哪里pull下来的?
experiment 4: pull image not cached in the registry from a another node, read the docker logs, first and second time, something interesting happend

```
给人的感觉是反了, 优先级反了, 难道是优先级的问题?  
8) docs.docker.com --> product manuals --> 左边open-source projects --> docker registry --> configuring a registry 搜proxy: The proxy structure allows a registry to be configured as a pull-through cache to Docker Hub. See mirror for more information. Pushing to a registry configured as a pull-through cache is unsupported.!!   
9) docker logs show: "Adding new scheduler entry for" for the first pull a library/busybox through 192.168.1.127, with http.response.duration=4.186213634s. And there are no "Adding .." for a second pull, with duration=2.542149ms, is that means second pull is thrugh the cache?  
