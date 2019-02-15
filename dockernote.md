
# docker
1) nvidia-docker: https://github.com/NVIDIA/nvidia-docker 里面的蓝字各种点, 各种链接非常有用。如果要装docker2, 要docker 18.09.1~0-3...  
1.5) nvidia-docker(github) ---> 点 blog post ---> 点 repository ---> 就到了hub.docker.com/r/nvidia/cuda/  
2) https://hub.docker.com/r/nvidia/cuda/ 这里有各种镜像的dockerfile, 在nvidia的gitlab里...  
3) mirrors.aliyun.com ---> docker-ce ---> Related links --> curl脚本安装就直接安装了  
4) 但是上面的可能不是最新版本, 于是去docker官网, https://docs.docker.com/ ---> Get Docker ---> 左边列 ---> Linux ---> 一步一步做, 答案的删, ok  
5) 常用命令:
```
sudo pkill -SIGHUP dockerd
sudo docker run --runtime=nvidia --rm nvidia/cuda:9.0-base nvidia-smi
sudo nvidia-container-cli --load-kmods info #要根据本机的版本来选择镜像
```
注意run的时候要加上--runtime !  
6) laning-ecg-cloud-test目录(服务的包),pyenv都可以映射到docker中,就不用拷贝到里面了, pyenv最好是装到docker里面..?  
7) docker search xxx 这样搜索基本镜像还是有价值, 如果是直接在官网pull 镜像, 那慢得一匹, 所以可以用阿里的镜像加速器..?, 修改/etc/docker/daemon.json:  
可以参考阿里云的说明: 在阿里云管理控制台-->产品与服务-->弹性计算-->容器镜像服务
```
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://nv2ni2pp.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```
8) docker attach 进去之后, ]# ps, 发现bash的pid是1, bash就是这个docker的上帝进程, 退出就是退出上帝进程, 然后docker就关了。而一般系统的上帝进程是system。 
9) Dockerfile建了个httpd的docker, 端口映射的话, 要放到前面:
```
[root@mini dockerfile1]# docker run -d -p 8000:80 -v /var/ftp/anli/admin/1:/var/www/html -it mycentos:http
```
10) Dockerfile 引用官网一句话: "The docker build command builds an image from a Dockerfile and a context. The build’s context is the set of files at a specified location PATH or URL. The PATH is a directory on your local filesystem. The URL is a Git repository location." context是这意思?
11) Dockerfile ADD 是不保留连接的!
12) Dockerfile 的默认解释器是/bin/sh, 怎样设置成/bin/bash?
13) 如果是环境变量的话, 用ENV稳妥点, 但是怎么用~/.bashrc呢?
14) Dockerfile 的$HOME, 即~/是 WORKDIR
15) Dockerfile 可以 Using cache 怎么控制?

