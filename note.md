# 常用命令:
ctrl+shift+c ---> ctrl+shift+v linux复制粘贴  
alt+tab 选择  
vim中: 17+G ---> 跳转到第17行, shift+G ---> 跳转到最后一行
tab不出来? ---> yum list | grep bash ---> 有completion的,装了, 还不行? yum -y install *-completion   
http://www.gnu.org/software/bash/manual/bashref.html 牛逼了!  

# mypyhton  
arraybag.py中, 如果没有 __iter__ 方法, 那么下面的 __str__ 方法就不能用了, 因为ArrayBag就不支持迭代了  
  
# yum  
阿里yum源: http://mirrors.aliyun.com ---> https://opsx.alibaba.com/mirror  
  
# jumpserver  
创建用户邮件发送没有成功, 可能是因为内存不够, jumpserver的消息先放到队列中。  
  
# gitlab  
配置smtp, 新建用户发送邮件:  
官网搜索smtp  
vim /etc/gitlab/gitlab.rb https://github.com/frnorth/note/blob/master/gitlab.rb  
gitlab-ctl reconfigure 重新加载配置  
gitlab-ctl tail 看日志  
貌似要是starttls_auto true 那么gitlab-tls 也得是ture
貌似要加上那个git_user_email

# ubuntu 14.04
1) dd命令制作u盘启动盘:  
```
df -h  (fdisk -l)
umount /dev/sdb4
mkfs.vfat /dev/sdb -I
dd if=ubuntu-14.04.5-desktop-amd64.iso of=/dev/sdb
```
2) 然而dd命令只能用来制作linux启动盘, 制作win10启动盘可以用woeusb:  
```
sudo add-apt-repository ppa:nilarimogard/webupd8
sudo apt update
sudo apt install woeusb 
```
如果报错:"E: 有未能满足的依赖关系。请尝试不指明软件包的名字来运行“apt-get -f install”(也可以指定一个解决办法):"  
```
sudo apt-get --fix-broken install
```
然后打开woeusb软件  

# windows
笔记本外接显示器后, 在显示中可以设置主显示器, 这样禁用笔记本的自带显示器。  
接上外接显示器后没有声音, 可以在声音的设置中, 选择声音的输出设备。  

# sshd 服务
sudo apt-get install openssh-server
ps -e | grep ssh    ps auz | grep ssh
sudo /etc/init.d/ssh start

# docker
1) nvidia-docker: https://github.com/NVIDIA/nvidia-docker 里面的蓝字各种点, 各种链接非常有用。 
2) https://hub.docker.com/r/nvidia/cuda/ 这里有各种镜像的dockerfile, 在nvidia的gitlab里...
3) mirrors.aliyun.com ---> docker-ce ---> Related links --> curl脚本安装就直接安装了  
4) 但是上面的可能不是最新版本, 于是去docker官网, https://docs.docker.com/ ---> Get Docker ---> 左边列 ---> Linux ---> 一步一步做, 答案的删, ok
5) 常用命令:  
```
sudo pkill -SIGHUP dockerd
sudo docker run --runtime=nvidia --rm nvidia/cuda:9.0-base nvidia-smi
sudo nvidia-container-cli --load-kmods info #要根据本机的版本来选择镜像
```
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
7) docker attach 进去之后, ]# ps, 发现bash的pid是1, bash就是这个docker的上帝进程, 退出就是退出上帝进程, 然后docker就关了。而一般系统的上帝进程是system。

[wangjie@PC_wyw:tmp]$ cd lanjing-ecg-cloud-test/
[wangjie@PC_wyw:lanjing-ecg-cloud-test]$ ll
总用量 244
-rw-rw-r--  1 wangjie wangjie    520  1月 23 10:56 README.MD
-rw-rw-r--  1 wangjie wangjie   1058  1月 23 10:56 requirements.txt
[wangjie@PC_wyw:lanjing-ecg-cloud-test]$ pyec^C
[wangjie@PC_wyw:lanjing-ecg-cloud-test]$ pyenv-->python3.6-->pip install -r requirements.tx^C
8) Dockerfile建了个httpd的docker, 端口映射的话, 要放到前面:
```
[root@mini dockerfile1]# docker run -d -p 8000:80 -v /var/ftp/anli/admin/1:/var/www/html -it mycentos:http
```

# 用户空间与权限
1) 我是服务器的管理员, 我要给其他人添加账号到服务器上, 并把他的公钥拷到电脑, 让他能ssh登陆:  
```
sudo su - root
useradd u1 -s /bin/bash -m   (-s 登陆的解释器, 很重要, -m 创建家目录)
cd /home/u1
mkdir .ssh     (可能u1的加目录下并没有ssh)
vim authorized_keys   (把公钥复制到这个文件中)
chmod 600 authorized_keys
cd ..
chmod 700 .ssh
```

# pyenv 与 conda
两者再 github 上都有文档  
pyenv 中有 pyenv-virtualenv 的链接
git clone 下来 pyenv ---> git clone 下来 pyenv-virtualenv  
要想使用 conda, 先安装 anaconda, 或者 miniconda (包少), github上搜conda ---> 跳到conda官网 ---> getting started with conda ---> 有一句话: before you start you should have already installed Anaconda  
pyenv 可以管理 conda, 但是怎么样像pyenv的github上的方法去管理conda的虚拟环境呢?  
[root@mini ~]# cat .bash_profile | tail -1 | awk '{print $2,$3}' 哈哈, 牛逼了
