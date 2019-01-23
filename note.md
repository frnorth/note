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
\ 1) dd命令制作u盘启动盘:  
\ ```
\ df -h  (fdisk -l)
\ umount /dev/sdb4
\ mkfs.vfat /dev/sdb -I
\ dd if=ubuntu-14.04.5-desktop-amd64.iso of=/dev/sdb
\ ```
> 2) 然而dd命令只能用来制作linux启动盘, 制作win10启动盘可以用woeusb:  
> ```
> sudo add-apt-repository ppa:nilarimogard/webupd8
> sudo apt update
> sudo apt install woeusb 
> ```
> 如果报错:"E: 有未能满足的依赖关系。请尝试不指明软件包的名字来运行“apt-get -f install”(也可以指定一个解决办法):"  
> ```
  sudo apt-get --fix-broken install
> ```

# sshd 服务
sudo apt-get install openssh-server
ps -e | grep ssh    ps auz | grep ssh
sudo /etc/init.d/ssh start
