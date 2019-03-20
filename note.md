# 常用命令:
1. ctrl+shift+c ---> ctrl+shift+v linux复制粘贴  
2. alt+tab 选择  
3. vim中: 17+G ---> 跳转到第17行, shift+G ---> 跳转到最后一行  
4. tab不出来? ---> yum list | grep bash ---> 有completion的,装了, 还不行? yum -y install *-completion   
5. http://www.gnu.org/software/bash/manual/bashref.html 牛逼了!  
6. xshell的会话选项卡: 查看--->会话选项卡  xshell ctrl+鼠标左键, 可以定位光标!  
7. echo -e 'haha\n' -e 处理特殊字符  
8. sed -i '/haha/i yeah' xxx.txt 这样在含有haha字的上一行插入yeah  
9. ctrl+z 放到后台并挂起, bg+%+n 运行后台挂起的, jobs, fg, xxxx &  
10. unrar x xxx.rar 解压 绝对路径  
11. yum list installed | grep ^tk 看安装了的包  
12. 一般来说, 使用smtp是通过phpmailer实现的, vim 1.php --> <?php echo (extension_loaded('openssl')?'SSL loaded':'SSL not loaded')."\n"; ?> --> php 1.php 看openssl有没有加载到php中  
13. cat /proc/cpuinfo 等等  
14. 当前有10个目录d1-d10, 每个目录下面有一个目录d1/d11, d2/d21..., d11, d21下有很多数据。如果想看d11, d21... 和d11, d21...下面的第一个数据: for i in `ls`; do echo "$i"; ls $i/`ls $i` | head -1; echo '';done  
15. git 的工作目录下误删了文件1.txt --> git checkout 1.txt, 这样就恢复到了最新版本.  
16. application.yml 下面可以定义日志文件的拆分.  
17. vim中 /docker\c 这样可以忽略大小写查找  
18. ubuntu --> dpkg -l | grep xx --> dpkg -L xxx  
19. export LANG=zh_CN.UTF-8 export LANG=en_US, vim ~/.bashrc --> 加上  alias cc='LANG=C cc' alias gcc='LANG=C gcc'
20. 添加路由: route add -net 192.168.1.92 netmask 255.255.255.255 gateway 192.168.1.1  

21. 
```
netstat -nutpl | grep 12345
tcp6       0      0 :::12345                :::*                    LISTEN      23456/C    
lsof -i:12345
```
这样可以看到所有占用此端口的进程.  

# nagios
邮件设置的时候ssl用得了, tls用不了.., 下面这个配置是可以用的
```
Admin --> System Config --> Manage Email Settings:
Send Mail From: 15208104078@163.com	
Mail Method: SMTP
Debug Log: yes	
Host: smtp.163.com
Port: 465
Username: 15208104078
Password: (密码)
Security: SSL
--> send a test email --> (如果有必要)change your email address: 只把邮件改成763211690@qq.com就可以了
```

# mypyhton  
arraybag.py中, 如果没有 __iter__ 方法, 那么下面的 __str__ 方法就不能用了, 因为ArrayBag就不支持迭代了  
  
# yum  
阿里yum源: http://mirrors.aliyun.com ---> https://opsx.alibaba.com/mirror  
  
# jumpserver  
1) https://www.cnblogs.com/huangyanqi/p/9438991.html#autoid-0-0-0  
2) 创建用户邮件发送没有成功, 可能是因为内存不够, jumpserver的消息先放到队列中。  
3) 字符界面登陆
```
ssh -p2222 admin@192.168.244.144
sftp -P2222 admin@192.168.244.144
密码: admin
```
4)有人想通过跳板机连接跳板机管理的资产, 那么要:
> 1. 用户管理 --> 添加用户 (发送邮件貌似没啥用) --> 这个是跳板机xxx.xxx.xxx.xxx上的用户, 别人通过ssh连接, 把公钥考到.ssh/authorized_keys中。
> 2. 资产管理(老版本的在: 授权管理) --> 添加系统用户 (自动生成密钥, jumpserver自动将公钥放到资产的.ssh/authorized_keys中, 私钥自己保存) --> 这个是要被推送到资产上的用户, 在资产的家目录.ssh/authorized_keys中的公钥与跳板机上的一般不同。
> 3. 权限管理 --> 创建新的授权规则 --> 目的是将(用户、资产、资产上的用户)关联起来!
> 旧版在第1步创建完用户后, 会直接在跳板机上找到这个中户, id user1, 而新版的就不会在跳板机上建立用户了, 只能直接连接jumpserver:ssh -p xxxx user1@xxx.xxx.xxx.xxx 然后操作
5) 一般来说跳板机上设置了防火墙, 而且jumpserver服务设置了对外地址url 127.0.0.1, 和监听的地址127.0.0.1, 那么只能ssh -X jump -p xxxx, 然后firefox用网页操作, 这样很卡。  
```
sudo iptables -L INPUT --line-numbers
sudo iptables -I  INPUT 1  -p tcp  --dport xxxx(jumpserver网页端口) -j ACCEPT
修改jumpserver配置文件:
url = xxx.xxx.xxx.xxx  地址
ip = xxx.xxx.xxx.xxx  监听地址
sudo ./server.sh stop
sudo ./server.sh start
然后就可以在外网访问操作了, 操作完后再:
把jumpserver的配置改回去, 然后重启
sudo iptables -D INPUT 1
```
6) 如果有人想往资产上上传文件, 那么在跳板机的fileuser的加目录下, 将这个人的公钥考到.ssh/authorized_keys中, 然后再资产上配置.ssh/config (可以按照已有的人的配置来配)。用户先将文件scp到跳板机fileuser的加目录下, 然后再在资产上通过scp将fileuser上的文件拉过来。

  
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

# 用户空间与权限
1) 我是服务器的管理员, 我要给其他人添加账号到服务器上, 并把他的公钥拷到电脑, 让他能ssh登陆:  
```
sudo su - root
useradd u1 -s /bin/bash -m   (-s 登陆的解释器, 很重要, -m 创建家目录)
cd /home/u1
mkdir .ssh     (可能u1的加目录下并没有ssh)
vim authorized_keys   (把公钥复制到这个文件中)
chmod 600 authorized_keys
cd .. && chmod 700 .ssh
chown -R u1:u1 .ssh (要把属主和属组改成u1)
passwd u1	(改密码)
vim /etc/sudoers 在root下面填上: u1 ALL=(ALL:ALL) ALL 添加sudo权限
```

# postgresql
1) psql -d mydb -f xxx.sql 通过sql导入数据库

# nagios
1) 安装nagios, 需要一个干净的机器

# swap
nagios 经常报swap没有
```
cat /proc/swaps		看虚拟内存
swapon -s		看虚拟内存
cat /proc/sys/vm/swappiness	看系统对虚拟内存的依赖程度, 0是完全依赖物理内存
free			看内存
dd if=/dev/zero of=/var/swap bs=1024 count=6144000	设置虚拟内存
ls /var/swap 		有了
mkswap /var/swap	设置虚拟内存, 或者mkswap -f /var/swap	
swapon /var/swap	设置
free			有了
cat /proc/swaps		有了
echo "/var/swap   swap  swap  defaults  0  0" >> /etc/fstab		添加永久
```

# hbase
1) 连到机器上
```
hbase shell
get 'block','xxxxxx-xxxxxxxx' 这个rowkeys(xxxxxx-xxxxxxxx)是不同的业务不同的id.
```

# jenkins
系统管理 --> 用户管理 可以添加用户  
系统管理 --> 全局安全配置 将新建的用户添加进来, 并选上Read, 这个用户才有全局视图, 然后这个用户登陆才不会出现 "Access Denied 没有Overall/Read权限"  
项目 --> 把用户添加进来, 然后可以赋予权限.  







