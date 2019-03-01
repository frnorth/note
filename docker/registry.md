# Registry
1) registry文档: docs.docker.com --> product manuals --> 左边open-source projects --> docker registry  
2) docker-compose文档: docs.docker.com --> product manuals --> 左边docker compose  
  - 也可以到github上下载安装 --> 连接Compose repository release page on GitHub --> https://github.com/docker/compose/releases 最下面有直接的包下载?  

## CentOS
1) 用openssl生成证书前, 要先修改/etc/pki/tls/openssl.cnf, [v3_ca]下面添加IP, 不然会报错 "...IP SANs...", 而且貌似只能写一个IP, 如果写两个, 就以第2个为准, 而且这个会写到证书里, 如果如与登陆的不一样, 会报不一致的错误。  
2) /etc/docker/certs.d/下面还是要建个192.168.1.127目录, 然后把domain.crt放到里面, 不然docker login后会报错Error response from daemon: Get https://192.168.1.127/v1/users/: x509: certificate signed by unknown authority。  
3) domain.crt 要放到/etc/pki/ca-trust/source/anchors/ 下面, 不然curl会报一段错。Trust the certificate at the OS level.  
4) 2)和3)在别的客户端也要做。  
5) docker-compose.yml中, REGISTRY_HTTP_ADDR: 0.0.0.0:443 # 没有这个会报错: 拒绝连接 (容器内没有监听地址), 而配置文件任意内容写错, 都会导致容器启动不对, 哪怕本地有443端口开启。  
```
]# docker pull registry:2  
]# mkdir /root/docker
]# cd /root/docker
]# vim /etc/pki/tls/openssl.cnf
    [ v3_ca ]
    # Extensions for a typical CA
    subjectAltName = IP:192.168.1.127
]# mkdir certs  
]# openssl req -newkey rsa:4096 -nodes -sha256 -keyout certs/domain.key -x509 -days 365 -out certs/domain.crt  
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
