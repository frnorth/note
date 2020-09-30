# 常用命令:
1. ctrl+shift+c ---> ctrl+shift+v linux复制粘贴  

2. alt+tab 选择  

3. vim中: 17+G ---> 跳转到第17行, shift+G ---> 跳转到最后一行  

4. tab不出来? ---> yum list | grep bash ---> 有completion的,装了, 还不行? yum -y install \*-completion   

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

22. watch -n 0.2 nvidia-smi 0.2s一看  

23. vim中, ctrl + v 可以选择块(列, 行当然也行), y复制, p粘贴, x删除, 一样的.  

24. vim中, 在某个单词的位置按*(shift + 8), 可以找出文本中所有这个单词, 按n切换. 

25. NAME=bak-`date +%m-%d`

26. find命令找./, 会把'./'带上, 所以要过滤掉
```
find ./backup/ -maxdepth 1 -mtime 30 | grep -v '^./backup/$' | xargs -i rm {} -rf
```

27. 往~/.bash_profile中写写写, 然后 ". ~/.bash_profile" 就可以了  

28. 如果只找到了某些词, 而忘记了这些词在哪个文件:
```
for i in `find ./ -type f`; do echo $i; cat $i | grep INT_MIN; done
```

29. 安装deb包  
```
sudo dpkg -i ./wkhtmltox_0.12.5-1.xenial_amd64.deb 
sudo apt-get install -f 
dpkg -l|grep wkht
dpkg -l|grep html
dpkg -l|grep html|grep pdf
dpkg -l|grep wkhtm
wkhtmltopdf -h
```

30. github ssh不能用了, 可以改用https, 同时为了不每次都输入密码:
```
vim /root/C/.git/config
url = https://github.com/frnorth/C
[credential]
    helper = store
```

31. ssh 用私钥jump(id_rsa)和config文件, 远程连接, config:
```
Host jump
  User wangjie
  Hostname xxx.xxx.xxx.xxx
  Port xxxx
  IdentityFile ~/.ssh/jump
```

32. cat /proc/version 可以看系统的版本  

33. 阿里yum源: http://mirrors.aliyun.com ---> https://opsx.alibaba.com/mirror  
    
34. dd命令制作u盘启动盘:  
```
df -h  (fdisk -l)
umount /dev/sdb4
mkfs.vfat /dev/sdb -I
dd if=ubuntu-14.04.5-desktop-amd64.iso of=/dev/sdb
```
然而dd命令只能用来制作linux启动盘, 制作win10启动盘可以用woeusb:  
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

35. windows 笔记本外接显示器后, 在显示中可以设置主显示器, 这样禁用笔记本的自带显示器. 接上外接显示器后没有声音, 可以在声音的设置中, 选择声音的输出设备。  

36. sshd 服务
```
sudo apt-get install openssh-server
ps -e | grep ssh    ps auz | grep ssh
/etc/ssh/sshd_config #中，要把端口打开，监听地址打开还要允许用户密码登录。
    Port 22
    ListenAddress 0.0.0.0
    PasswordAuthentication yes
sudo /etc/init.d/ssh start
```
如果时启了一个centos的docker, 那么:
```
yum -y install openssh-server
ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
ssh-keygen -t rsa -f /etc/ssh/ssh_host_ed25519_key
ssh-keygen -t rsa -f /etc/ssh/ssh_host_ecdsa_key
/usr/sbin/sshd
```

37. 用户空间与权限
我是服务器的管理员, 我要给其他人添加账号到服务器上, 并把他的公钥拷到电脑, 让他能ssh登陆:  
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

38. swap内存  
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

39. `https://docs.nginx.com/nginx/admin-guide/load-balancer/http-health-check/` 甚吊  

40. 找含有某个字的文件:
```
for i in `find ./ -type f`; do echo $i; cat $i | grep itoa; done
```

41. ps aux | grep xxx -- 第3列, 第4列, 就是占用的cpu, men多少.  

42. windows 上竟然也可以用ubuntu! linux 子系统:
```
设置 --> 更新与安全 --> 开发者选项 --> 开发人员模式
控制版面 --> 启用或关闭Windows功能 --> 适用于Linux的Windows子系统
打开cmd --> C:\Users\WangJie>bash --> 有提示, 访问连接, 是到了应用商店里, 下载安装ubuntu就可以了
在cmd 输入bash或者, 开始菜单点ubuntu就可以进去了.
```

43. frp内网穿透: `https://github.com/fatedier/frp`  

44. ssh 连接经常掉线
```
echo "    ServerAliveInterval 60" >> /etc/ssh/ssh_config
```

45. rm -rf 删除 恢复? https://blog.csdn.net/yown/article/details/44836439 或 foremost  

46. 小米6电源键坏了, 怎么开机? 接上电源的瞬间, 长按音量+键, 然后进入mi-recovery, 长时间不操作, 默认重启.  

47. 直接修改/etc/passwd, 可以改登陆的解释器  

48. hash ?  

49. nc -vz 192.168.1.121 7180

50. sudo ln -s /home/wangjie/note/sh/findcontext.sh  /usr/bin/findcontext 

51. matlab: disp("Hello World!")

52. 改命令提示符
```
    PS1='${debian_chroot:+($debian_chroot)}\u\
\033[36m@\033[0m\
\033[35m⚡ \033[0m\
\033[33m\h\033[0m\
\033[35m⚡ \033[0m\
[\033[34m\w\033[0m]\$ '

```
