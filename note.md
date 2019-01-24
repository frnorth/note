# 常用命令:
ctrl+shift+c ---> ctrl+shift+v linux复制粘贴  
alt+tab 选择  
vim中: 17+G ---> 跳转到第17行, shift+G ---> 跳转到最后一行

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

# sshd 服务
sudo apt-get install openssh-server
ps -e | grep ssh    ps auz | grep ssh
sudo /etc/init.d/ssh start

## docker
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


[wangjie@PC_wyw:tmp]$ cd lanjing-ecg-cloud-test/
[wangjie@PC_wyw:lanjing-ecg-cloud-test]$ ll
总用量 244
drwxr-xr-x 12 wangjie wangjie   4096  1月 23 10:56 ./
drwxrwxrwt  9 root    root      4096  1月 23 17:56 ../
drwxrwxr-x  3 wangjie wangjie   4096  1月 23 10:56 business/
-rw-rw-r--  1 wangjie wangjie   1746  1月 23 10:56 config.py
drwxrwxr-x  7 wangjie wangjie   4096  1月 23 10:56 data/
-rw-rw-r--  1 wangjie wangjie 163653  1月 23 10:56 demo.pdf
drwxrwxr-x  3 wangjie wangjie   4096  1月 23 10:56 ecg_report_server/
-rw-rw-r--  1 wangjie wangjie      0  1月 23 10:56 ecg_report.sql
-rw-rw-r--  1 wangjie wangjie  12756  1月 23 10:56 grpc_client.py
drwxrwxr-x  5 wangjie wangjie   4096  1月 23 10:56 hrv/
drwxrwxr-x  4 wangjie wangjie   4096  1月 23 10:56 label_system/
drwxrwxr-x  2 wangjie wangjie   4096  1月 23 10:56 libs/
-rw-rw-r--  1 wangjie wangjie    549  1月 23 10:56 manage.py
drwxrwxr-x 15 wangjie wangjie   4096  1月 23 10:56 model-service/
drwxrwxr-x  5 wangjie wangjie   4096  1月 23 10:56 pdf/
drwxrwxr-x  3 wangjie wangjie   4096  1月 23 10:56 persistence/
drwxrwxr-x  2 wangjie wangjie   4096  1月 23 10:56 __pycache__/
-rw-rw-r--  1 wangjie wangjie    924  1月 23 10:56 README.md
-rw-rw-r--  1 wangjie wangjie    520  1月 23 10:56 README.MD
-rw-rw-r--  1 wangjie wangjie   1058  1月 23 10:56 requirements.txt
[wangjie@PC_wyw:lanjing-ecg-cloud-test]$ pyec^C
[wangjie@PC_wyw:lanjing-ecg-cloud-test]$ pyenv-->python3.6-->pip install -r requirements.tx^C

