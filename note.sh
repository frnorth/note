正则：
^	匹配行首
$	匹配行尾
[]	集合，匹配集合中的任意单个字符
[^]	对集合取反
.	匹配任意单个字符
*	匹配钱一个字符任意次数（*不允许单独使用）
\{n,m\}	匹配一个字符n到m次
\{n\}	匹配钱一个字符n次
\{n,\}	匹配一个字符n次以上
\(\)	保留

扩展正则：
+	最少匹配一次，1~n个字符
？	最多匹配一次，出现或者没出现
{n,m}	匹配n到m次
()	组合为整体保留
|	或者
\b	单词边界

egrep, sed -r 才支持扩展正则。

grep -P.............
让grep支持perl的正则表达式语法。

(?<xx>正则)	相当于(正则)保留复制
\d	整数
JSON正则？


重定向：
man bash 找/dev/tcp 可以看到各种各种定向的解释
exec 永久修改重定向，试一试exec 1>f1 然后各种ls cat 都会重定向到f1。
exec 15> f1
echo abc >&15
这样就定义了一个文件描述符。

echo -n (不自动换行) -e(特殊符号特殊处理 如\n) -r光标移动一行首，但是不换行。

#!/bin/bash
exec 12<>/dev/tcp/www.baidu.com/80
echo -ne "GET / HTTP/1.1\r\n" >&12
echo -ne "Host: www.baidu.com\r\n" >&12
echo -ne "User-Agent: curl\r\n" >&12
echo -ne "\r\n" >&12
cat <&12
:wq
\r\n是http协议区分上一行与下一行的分隔符
运行这个脚本!
在网络底层，以通讯协议的形式，封装数据报文
如果是https的，还要自己加密解密

0	stdin
1	stdout
2	stderr

[root@logstash ~]# who 可以看登陆的用户和终端编号，直接w回车!!!(但是得点开大屏。)

--->A ssh B
A: echo "Hi" > /dev/pts/1
B就可以接受到Hi
A: wall "Hello" 是对所有链接到这台机器的pts说Hello

vim -O2 file file2
Ctrl+w l 	切换到右屏（Normal模式下）
Ctrl+w h 	切换到左屏

/dev/null黑洞设备

有时候重启不管事
要先关机再重启。

强制关机，然后点运行（强制重启不管用）
e----> linux16那一行尾 添加rd.break console=tty0 --->ctrl+x
mount -o remount,rw /sysroot #挂载/sysroot
chroot /sysroot #切换至系统
各种操作
touch /.autorelabel #更新系统信息文件（touch /.autorelabel 这句是为了使得selinux生效，否则将无法正常启动系统）


系统启动后，启动的最后会执行一个脚本:
[root@room9pc01 myfiles]# ls -l /etc/rc.local
lrwxrwxrwx. 1 root root 13 3月  13 2018 /etc/rc.local -> rc.d/rc.local
把一些命令写到这个脚本中，如mount，则可以自动化。但是要加执行权限，快捷方式和源文件都要加。

>正确信息重定向，2>错误信息重定向，&>正确错都都收集重定向。

/etc/fstab开机挂载的配置文件
设备路径 挂载点 文件系统类型 参数 备份标记 检测顺序

[root@mysql mysql]# echo  "export  PATH=/usr/local/mysql/bin:$PATH"
 >> /etc/profile
环境变量？

/etc/profile 是一个脚本，如果用bash /etc/profile， 是开一个子进程执行这个脚本，进程结束，脚本运行的结果也消失。source /etc/profile是在当前进程。

系统变量都定义在/etc/profile中。

PATH 命令搜索路径

1.export PATH=/usr/local/nginx/bin:$PATH
立即生效
临时有效，关闭终端后恢复失效。
仅对当前用户有效。

2.vim ~/.bashrc 在最后一行添加：
export PATH=/usr/local/nginx/bin:$PATH
重启终端生效，或 source ~/.bashrc生效。
永久有效
仅对当前用户有效

3.~/.bash_profile 与 ~/.bashrc 的区别是:
bash_profile 是登陆shell生效, 所以要想立即生效要: exec $SHELL, $SHELL 一般是/bin/bash
exec的意思是, 退出当前的shell然后再重启一个。
http://www.gnu.org/software/bash/manual/bashref.html 这里竟然!
是这样嘛???

4.vim /etc/profile
echo  "export  PATH=/usr/local/mysql/bin:$PATH" >> /etc/profile
source /etc/profile 或 重启系统生效
永久有效
不限用户。

5.vim /etc/environment
PATH="/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
重启系统生效
永久有效
不限用户。

源码安装的没法用system start启动


centos6中都是手动编脚本启动服务的 在/etc/init.d中


一个好的启动脚本应该有：a start    a stop	a restart	a status


/var/log/secure日志可以查看错误登陆信息，可以用来过滤入侵者，错误密码错误用户都能看
Sep 19 13:48:36 room9pc01 sshd[27093]: Invalid user tom from 192.168.4.254 port 41766


free的第4列free是什么意思？


clone_auto7 回车 输入4 就直接出4台虚拟机了...


给虚拟机添加网卡后，可以用  nmcli connection add con-name eth1 ifname eht1 type ethernet  来添加配置文件


打开浏览器按f12可以看抓包，而且还可以看一些公司的招聘信息


www.baidu.com/index.php可以访问
www.baidu.com/index.py就不行了


不要用yum安装nginx，有复杂的方式不要用简单的，因为yum安装不是自定义的，而且现在软件都是模块化设计，yum是全部安装，生产环境要用源码安装自定义


安装nginx前，先创建一个普通用户，以便用这个用户启动nginx


nginx官网有歌各种模块的说明

nginx也可以配置虚拟主机 server, 存放在conf.d/下面，include conf.d/*
结构耐人寻味!

pcre支持正则表达式，-devel的意思是依赖包


问题：
413 远程服务器返回错误，Request Entity Too Large
  原因：通过post上传文件过大
  解决：扩大流量
        server{ 
          ...
	      client_max_body_size 20m;
          client_body_buffer_size 128k; (??)
          ...
        }


http://ecg-java.landmind.cn/front/index.html
直接访问ecg-java.landmind.cn就跳转到/front/index.html怎么设置？



network没有启动成功，还有可能是因为BOOTPROTO=dhcp，但是没有dhcp服务器,eth0没有使用，但是ifcfg-eth0中写着BOOTPROTO=dhcp，所以不行，要把dhcp改成none
总结一下复制添加ifcfg-ethx：
1.复制
2.改eth0 dhcp-none
3.改ethx dhcp-none 注释掉UUID NAME=ethx DEVICE=ethx IPADDR=想要的IP



[root@proxy nginx-1.10.3]# ps aux | grep nginxi      看看是否 权限降级
root      5511  0.0  0.1  45840  1116 ?        Ss   11:28   0:00 nginx: master process /usr/local/nginx/sbin/nginx
nginx     5512  0.0  0.1  48364  1968 ?        S    11:28   0:00 nginx: worker process
root      5563  0.0  0.0 112676   984 pts/0    R+   11:32   0:00 grep --color=auto nginx

proxy_set_header Host $http_host;
proxy_set_header X-Real-Ip $remote_addr;


shell
//////////////////////////////////////////////////////////
shell数组：
l1=(1 2 3 4)

sed -i '1i xxxxx' xxxx 插入到第一行前




可以用nginx学c语言


killall nginx强制关


硬盘   内存
程序   进程
一个程序对应多个进程


    server{
        listen 80;
        server_name localhost;
        root html;   没有/就是相对路径， 意思是根目录是软件安装的目录
       }


tailf套路：
[root@proxy nginx-1.12.2]# tailf /usr/local/nginx/logs/error.log 


创业公司：
门户网站：宣传公司的
电商网站：交易的
论坛：
买了域名后要到哪里去备案


vim中
:85,96s/#//
%s/#//是全部替换
s////当前行
这样去掉某些行的注释


lnmp_soft中有别人写好的网站php_scripts---web_demo，可以复制到www中


基于ip的，首先电脑里要有俩网卡，俩ip


已经做了两个网站，但是如果只访问ip是谁在上面，访问谁


md5算法文件校验
[root@proxy ~]# vim 1.txt
[root@proxy ~]# md5sum 1.txt 
5a6d311c0d8f6d1dd03c1c129061d3b1  1.txt
当且仅当文件内容改变，这个值才改变
网上有些重要的软件就会有这个校验。
妙传也是基于md5


非对称加密  公钥(证书) 私钥  集有私钥，散有公钥
访问淘宝，淘宝先把公钥传给你，你用公钥加密，只有淘宝有私钥(不联网)
清华的一个家伙写过一本书
一般用非对称对称一起加密，先用非对称加密，把密码告诉对方，然后之后两人就用这个密码来对趁加密


./configure  检查缺不缺什么依赖包等，配置安装路径和用户等等
make 编译 C语言--二进制
make install 拷贝到相对应的路径


每种语言都有自己的适用
C 软件，系统
php 网页
python 运维，人工智能
java 软件，游戏，嵌入式


动态网站与地址重写


php默认不能连任何数据库，因为内置能连mysql，微软不乐意，前俩都内置，orical不乐意...
而如果全内置，太庞大
所以，这些都不内置，用扩展包来实现
原本php a.php只能解释一次，但是几千人访问，不能在这么整，所以要用php-fpm的作用是提供一个服务，只要有人访问，就用php去解释


centos官网有everything iso，这个光盘里有各种包，centos也有网络额yum源，国外的centos yum源太远了，国内有好多yum源，网易，阿狸，各种大学等等...


动态网站  要什么给什么
静态网站  先把a.php解释后，结果给用户


启了服务后，最好看一下端口 9000 3306 80是不是在用着


fastcgi.conf里面有很多内置变量，包含这个文件
index.php有啥用呢？
#fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
include        fastcgi.conf;
fastcgi_param一行写错了，而其实在fastcgi.conf有这个变量，所以包含fastcgi.conf就可以了，而且更快。


用discuzX搭论坛？


rewrite ^/ http://www.tmooc.cn/;
^/ 是任意匹配，只要开头是/，那部就是任意匹配
(.*) \1 shell中这样复制粘贴，nginx中用：(.*) $1


手机与pc，不同浏览器访问不同的页面


ua标示，在手机里可以设置，可以让手机伪装成电脑


last break 
///////////////////////////////////////////////
        rewrite /a.html /b.html last;
        rewrite /b.html /c.html last;

        location / {
            root   html;
            index  index.html index.htm;
        }
--------------------------------------------
        location / {
            root   html;
            index  index.html index.htm;
        }

        location /a.html{
            rewrite /a.html /b.html break;
        }
        location /b.html{
            rewrite /b.html /c.html;
        }
///////////////////////////////////////////////


redirect和permament是给蜘蛛看的，如果是临时的就用redirect，别写错，不要欺骗蜘蛛


写自己的博客。



operation 第3天
////////////////////////////////////////////////////////////////////////////////////////////////////

用户打开一个网站，www.baidu.com 没有说具体访问谁，就给他默认网页
index.html默认网页
index.php index.html 默认动态网页，默认静态网页，谁在前面，先找谁


~* 不去分大小写


nginx 网站服务器 代理服务器（调度器）


nginx 调度器，关个web1，就都访问web2了
max_fails 测试一次，发现坏了，再测试一次，直到测试到max_fails次数
fail_timeout 判定坏了后，隔fail_timeout时间再去测试


一个ip访问某一个服务器，那么以后就让其访问这个服务器，所以用ip_hash算法：
ip是字符串，怎么比较？
md5sum xxx  得出xxx的hash值（16进制的）
访问nginx的ip xxx.xxx.xxx.xxx 也有一个hash值
将这个hash值对2取余数，0给web1，1给web2。
查nginx官网 说只拿了ip地址的前3位(192)做的hash值，所以发现真机和client访问都是访问的一台，web2


以上是7层代理（调度），因为http是在应用层
而现在要搞4层代理，TCP/UDP。如在家里想远程单位电脑，就要有一个中间的调度器(nginx1.19以上的才行)
做了4层调度后，基本所有的服务都能做了


源码安装的只要删除那个目录就可以了如 rm -rf /usr/local/nginx


proxy_connect_timeout 10s 是啥意思？
proxy_timeout 是啥意思？


如果升级了nginx，那么一定要先killall nginx，然后才nginx启动


做一下mysql调度器？
然而会遇到一些问题：1.客户端要装mysql。2.root用户只允许从本地登陆，所以要先创建一个用户。
还有啥问题来着？
MariaDB [(none)]> grant all on *.* to tom@'%' identified by '123';


还有同步的问题，rsync


7里ss=netstat

ab 在 httpd-tools包中， 

ab -n 4000 -c 2000  2000人一共点4000次


epoll是一种算法，什么算法来着？


只优化nginx还不够，系统允许打开的最大文件数量是1024，这个也要优化


Hn与Sn是啥意思来着？


about:cache 不是aboutcache


浏览器缓存，让用户访问更快，将一些图片直接缓存到硬盘，节省流量和贷款


请缓存后访问200--刷一遍--304? 为啥我的没有出现过304?


F12很关键


[root@client ~]# ab -n 2000 -c 2000 http://192.168.4.5/
Completed 1600 requests
apr_socket_recv: Connection reset by peer (104)
Total of 1610 requests completed
这是什么意思？

nginx 编译安装的时候不一定必须指定用户？安装完，直接su - nginx -c /usr/local/nginx/sbin/nginx 这样启动呢？
==================================================================================================


operation 第4天
///////////////////////////////////////////////////////////////////////////////////////////////////
./configure --help 可以看有哪些模块


alow 'ip';
deny all;


Active connections: 1                      //并发量
server accepts handled requests
 11 11 18 
Reading: 0 Writing: 1 Waiting: 0 
http1.0 一次连接一次请求------三次握手四次断开占带宽，5G数据中4G都是握手断开消息。
http1.1 一次连接多次请求，保持连接。


后面的压缩，查某些文件对应的压缩文件是什么命令？


/usr/lib/systemd/system/ 这个目录非常重要


案例上没有的案例：web1与web2做nginx动态页面(.php)，proxy做调度器。


用户登陆网站，用户名与密码存为session(一个文件)到服务器上，为了区分不同用户的session，服务器给用户(浏览器)一个值，相当于md5那样的码，cookie。下次用户在访问，就用cookie这个值来找session。


要想 firefox 192.1668.4.5 这样就访问web1,web2的动态页面，web1,web2与proxy的nginx.conf的location里面的index 后面都要加 index.php


operation实验天
////////////////////////////////////////////////////////////////////////////////////////////////////////
nginx做proxy，并发优化，只需要优化调度器和客户端就可以了？
ulimit -Hn 100000 写到脚本中怎么没法使用？


1. 克隆 4 台新虚拟机,IP 配置如下:
虚拟机 7 eth2:201.1.1.100
虚拟机 8 eth2:201.1.1.5
eth3:201.1.2.5
虚拟机 9 eth3:201.1.2.100
虚拟机 10 eth3:201.1.2.200
a) 在虚拟机 7 上源码安装 Nginx 软件,要求如下:
b) 通过./configure --help 查看该软件支持的模块(--with开头)
c) 要求安装 ssl 模块、stream 模块以及 stub_status 模块
d) 安装前创建用户 nginx,安装时指定安装用户为 nginx
e) 百度搜索 nginx 的 stub_status 模块的作用,以及如何修改配置文件,通过 stub_status 查看 nginx 服务器的状态
2. 在虚拟机 7 上修改 nginx 配置文件,实现基于域名的虚拟主机:
a) 域名分别为 www.tarena.com 和 www.tedu.cn
b) 注意客户端验证需要修改/etc/hosts
c) 访问 www.tedu.cn 时会提示输入用户名与密码,输入正确才可以流量页面
d) 页面内容任意3. 虚拟机 8,9,10 均安装 nginx 软件作为服务器
a) 虚拟机 7 作为客户端
b) 虚拟机 8 的 nginx 配置为集群调度器,算法为轮询算法,集群池为 201.1.2.100 和 201.1.2.200,配置最大失败次数为 1,失败超时时间为 30 秒,201.1.2.100 的权重为 2
c) 虚拟机 9 和虚拟机 10 配置为 LNMP 环境,支持 PHP 动态页面
d) 在虚拟机 9 上创建测试页面(静态页面至少一个,连接数据库的动态页面至少一个,参考lnmp_soft/php_scripts/mysql.php)
e) 配置 rsync 自动将虚拟机 9 上的网页文件自动同步到虚拟机 10,确保两台主机的网页文件一致
4. 延续前面的实验,优化所有的 nginx 软件,要求如下:
a) 所有 nignx 均不要显示版本号(百度搜索)
b) 并发连接数调整为 65536
c) 调整后使用 ab 软件测试并发量
d) 使用“watch -n 1 ss -s”命令观察服务器连接数变化(每秒执行一次 ss 命令)
e) 百度搜索 ss -s 命令的用法
5. 附加题目:优化 Linux 内核参数,要求如下:
a) 百度搜索:tcp_syncookies 参数、用法、如果调整值
b) 百度搜索:tcp_fin_timeout 参数、用法、如果调整值
c) 百度搜索:tcp_retries 参数、用法、如果调整值6. 在虚拟机 9 和 10 上部署 PHP 登陆环境:
a) 部署 lnmp 环境(支持动静分离)
b) 部署测试性页面(参考 lnmp_soft/php_scripts/php-memcached-demo.tar.gz)
c) 测试登陆页面的效果
d) 查看/etc/php-fpm.d/www.conf 配置文件,确认 session 会话信息保存位置
e) 到/var/lib/php/session 目录下查看 session 文件
7. 使用 memcached 实现会话信息共享
a) 虚拟机 8 安装部署 memcached 缓存数据库
b) 修改虚拟机 9 和 10 的配置,让 PHP 保存会话信息到 memcached
c) 默认 PHP 无法连接 memcached,需要安装对应的扩展模块
d) 完成后再次通过集群调度器访问登陆页面,测试登陆效果(为了查看效果,可用将后台页面的背景颜色适当调整)

1) setyum.sh：找一台电脑，做一个http共享出rhel7.4光盘里的内容，然后给每台电脑运行这个脚本，就配好yum了
2) lnmp_install.sh：一键安装nginx，mariadb,php。nginx是源码安装。
3) nginx_base.sh：使nginx可以提供.php页面，以及查看状态status。
4）nginx_vmhost.sh：nginx做虚拟主机
5) nginx_proxy.sh：nginx当调度器 
6) install_inotify.sh与insync.sh：安装inotify，并让10同步9的/usr/local/nginx/html下的内容
7) nginx_noversion.sh：使nginx不显示版本
8) nginx_current.sh：优化nginx并发



operation day5
////////////////////////////////////////////////////////////////////////////////////////////////////////
java lanuage name ---JDK
we use open-JDK
3 port 8080 8005 8009
 
apache-httpd and nginx different port match different vm-server
tomcat one port match every vm-server(host), once the port ssl, every vm-server ssl

192.168.2.5 - - [28/Sep/2018:16:04:21 +0800] "GET / HTTP/1.1" 304 -
192.168.2.5 - - [28/Sep/2018:16:04:21 +0800] "GET /favicon.ico HTTP/1.1" 404 1016
192.168.2.5 - - [28/Sep/2018:16:04:21 +0800] "GET /favicon.ico HTTP/1.1" 404 1016
in the a_logs, what is this?

tomcat just like a ".sh" by java, java take the port

tomcat做虚拟主机，页面跳转，一定要建立对应的目录，不然tomcat启不来，起来两个端口，过一会就又关了

ali cdn (baidu search)

ps aux | grep varnish  check who(root or others) start the varnish

remember do not let other app started by root

why do not need --prefix= /usr/local/varnish ?

varnish缓存后，如果改了服务器页面，等一会，varnish就改了


operation day 5
////////////////////////////////////////////////////////////////////////////////////////////////////////
du -sh /var/lib/svn/project 可以看一个目录的大小

一般varnish可以这样做权限设置，先继承/，有特殊的写特殊的
[/]
harry=rw
tom=rw
[/harryfiles]
tom=r

svnserve -d -r /var/svn/project
killall svnserve

后台什么？

客户端也要装svn

svn mv cp mkdir ...

svn merge -r7:2 tuned.service 某一个版本写了不想让别人看的话，在以后的版本里想删除，那么将现在的版本还原到以前的某一个版本就行了，以后的就都没有这句话了，但是当前版本还是有的。

计划任务备份svnadmin

git---分布式  下载就是下载所有代码..？

https://github.com/xxxx(用户名)xxx/xx(仓库名)xxx

creatrepo?

GPL：可以随意复制，随意修改，再发布

.spec文件中  name version source0 三个不能乱写

%post 安装后脚本，如果在脚本中加上 wget http://xxx/id.??.pub 下载一个公钥，那么以后我就可以不用密码连到你的电脑中。

rpm -qpl xxx 可以看rpm包里都有啥，本质上rpm与exe一样...?

src目录里有.spec文件，用户可以参照这个文件自己再打包






//////////////////////////////////////////////




cluster
////////////////////////////////////////////////////////////////////////////////////////////////////////
集群与存储
192.168.4.50 client50
192.168.4.51 storage51

scsi 一种接口

das

nas  nfs smaba

san  ip_san fc_san

iscsi

把两台电脑的NetworkManager停了，为什么？
systemctl stop NetworkManager
systemctl disable NetworkManager

client50启httpd

lsblk

iscsi命名有规范..

man iscsiadm !!!!!可以找出需要的命令

硬盘分区格式化后才能使用所以：
fdisk /dev/sda  --> n --> 回车回车... -->w
mkfs.ext4 /dev/sda1

targit 登出，要先umount了之前的

target登出后，如果给client50再添加一块硬盘（总线类型scsi），那么再登进target，lsblk查看，target的盘就从sda变成了sdb.

udev 让硬盘名不变

添加硬盘的时候注意总线类型

获取硬件设备信息

将信息写到udev配置文件中

man 5 udev.conf

udevadm --help
udevadm info --help
...

history .... !xx

案例：
[root@client50 ~]# udevadm info -q path -n /dev/sdb
/devices/platform/host4/session2/target4:0:0/4:0:0:0/block/sdb
[root@client50 ~]# udevadm info -q all -p /devices/platform/host4/session2/target4:0:0/4:0:0:0/block/sdb -a  显示所有信息
vim /etc/udev/rules.d/20-iscsidisk.rules
SUBSYSTEM=="block",
ATTR{size}=="16777216",
ATTRS{model}=="diskb           ",
ATTRS{vendor}=="LIO-ORG ",
SYMLINK+="iscsi/vdb"
target登出再登入
[root@client50 ~]# ls -l /dev/iscsi/vdb 
lrwxrwxrwx 1 root root 7 10月  8 16:47 /dev/iscsi/vdb -> ../sdb1
mount /dev/iscsi/vdb/ /var/www/html/  可能会挂载不上，因为链接所指向的磁盘(文件)还没有分区和格式化，为什么我没有出现报错？而且后面多路径，直接[root@client ~]# mount /dev/mapper/mpatha1 /var/www/html/就可以用了..?
所以还要fdisk mkfs.ext4

添加网卡后可以这样激活
[root@storage51 ~]# ifdown eth3
[root@storage51 ~]# ifup eth3

[root@client50 ~]# mpathconf --user_friendly_names n

各两张网卡，登陆就两次target，会发现两个sdx，但是是同一个设备。
[root@client ~]# /usr/lib/udev/scsi_id --whitelisted --device=/dev/sda
3600140521f06d7417b941feaf8d663e6
[root@client ~]# /usr/lib/udev/scsi_id --whitelisted --device=/dev/sdb
3600140521f06d7417b941feaf8d663e6


cluster day02
////////////////////////////////////////////////////////////////////////////////////////////////////////

ext4   是本地文件系统
/proc/ 下的是内存中映射过来的，为文件系统

gfs    是全局文件系统

nfs    是网络文件系统  搭建nfs，客户端要nfs-utils

拓扑结构：
50 客户端 eth1 192.168.2.50
51 存储   eth0 192.168.4.51
52 web1   eth0 192.168.4.52
53 web2   eth0 192.168.4.53
54 rs     eth0 192.168.4.54
          eth1 192.168.2.54

开启内核的路由功能

[root@localhost ~]# sysctl -a | grep ip_forward  显示内核所有的参数
把xxxxxforward=1写到/etc/sysctl.conf中,那要怎样修改内核参数呢？
sysctl -p  显示生效的(写在/etc/sysctl.conf中的)内核参数。

NetoworkManger会影响一些东西，工作中根本不开
再指网关，52的网关192.168.4.54， 53的网关192.168.4.54
50要指 192.168.2.54
route add default gw 192.168.4.54

[root@localhost ~]# yum list | grep ipvs
ipvsadm.x86_64                          1.27-7.el7                 htyum        
[root@localhost ~]# yum -y install ipvsadm

lvs已经被集成再了linux内核中

ipvsadm -ln --stats
watch -n 1 ipvsadm -ln --stats
访问，可以看到你一次我一次

ipvsadm -S > ....  把修改后的覆盖到原来的上?
修改配置后或者清空配置后都要保存，不然重启服务后，又回来了
pvsadm -S > /etc/sysconfig/ipvsadm-config
ipvsadm -D -t xxx.xxx.xxx.xxx:xx 删除一个服务，d是删除一个real server

给eth0绑定一个虚拟ip 192.168.4.253
[root@localhost ~]# ifconfig eth0:1 192.168.4.253
把上面的那个命令放到/etc/rc.local中
[root@localhost ~]# vim /etc/rc.local

给web1 web2绑定 lo虚拟ip的时候，千万不要绑192.168.1.100，而是要绑192.168.1.100/32.因为如果绑了192.168.1.100，那么远程就挂了。如果是秘钥登陆的云主机，那么也远程不了，那么只能重启了。

系统重启后，会先读取/etc/rc.local
所以把一些临时设值生效的写到这个文件中，再开机，也可以生效。
echo 2 > /proc/sys/net/ipv4/conf/all/arp_announce  写到文件中
...

ifconfig lo:1 192.168.4.253/32 意思是没有网络位，就一个ip

/etc/rc.local 是一个链接指向 /etc/rc.d/rc.local，默认没有x权限，要 chmod+x /etc/rc.local 就直接给/etc/rc.d/rc.local加权限了。

远程秘钥位置
/root/.ssh/know_hosts


cluster day3
////////////////////////////////////////////////////////////////////////
keepalive 本质是一个vip切换工具？
比如再最后一阶段，两台nfsgw。keepallive只是负责切换ip? 

lvs-dr工作原理：
虚拟ip--vip进行分发，真实ip进行回包
52 53两个web服务器通过vip接受到信息，然后用真实ip帮助vip回应，所以内核参数aro_announce改成2，但是arp广播有可能先被52或53接收，所以要arp_ignore改成1。

公司的公网地址-----web52/53的vip地址！！！

ip addr show 专门查vip地址的

keepalive 谁的优先级高，谁就先获得vip
vrrp_strict 是禁止连接，所以虚拟ip会弄不上，要把这个注释掉

source xxx.sh（没有x）也可以

如果想让ipvsadm策略开机就生效那么：
/etc/sysconfig/ipvsadm-config里的下面这俩改一个？
IPVS_MODULES_UNLOAD="yes"
IPVS_SAVE_ON_STOP="no"
然后保存策略ipvsadm -S > /etc/sysconfig/ipvsadm !!!

advert_int 1 检查keepalive的心跳

keeplive可以对她的realserver做健康性检查

lvs     基于端口
haproxy 基于端口(4层)，基于软件(7层)，并可以做健康检查

haproxy.cfg:
listen mycat_3306 *:3306 #instead of :8066 more like mys
ql
    mode    tcp        # mysql 得使用 tcp 协议,set here not in the default maybe well
    option  tcpka      # 使用长连接,or every select will sent a connection
    balance leastconn  # 最小连接调度算法,when tcpka used, balance roundrobin was not suited. so leastconn


应用层上跑的是协议

请求头部信息
curl -v xxx.xxx.xxx/yy...
URI就是/yy...

haproxy的配置文件里是什么意思???



day4 环境
///////////////////////////////////////////////////////////////////////
50 
51 52 53 各加1块5g的盘，接口不限

linux如何从ftp上下载大文件：
yum -y install lftp
lftp Nsd1807:Nsd1807@176.204.13.13
-->cd xxxxxxxx
-->mget -c xxxx    下载到当前目录

hostname xxx ---- exit ---sshxxx 主机名就变了
再写到/etc/hostname中就永久了

时间同步检查：
node3改个时间
date -s "2018-9-9 9:9:9"

ext4日志文件系统---格式化后一部分用来存储 存储的日志，一部分存储数据
所以sda盘分两个区，一个存sdb的日志，一个sdc的日志，sdb sdc存数据

fdisk分区，存储的文件最大不能超过2G，用parted分可以

ceph-delopy命令要在工作目录下执行/root/ceph-cluster

块存储---硬盘

默认有个rbd存储池----文件夹
创建镜像就是从总空间中拿出一部分，不指定存储池，就创建再rbd池子中

ceph client和node1如果map了相同的镜像，文件不共享？

ssh 秘钥不好使了：
1.sign_and_send_pubkey: signing failed: agentrefused operation。
答:eval "$(ssh-agent -s)"
   ssh-add
2.UNPROTECTED PRIVATE KEY FILE!
答:文件对o有r权限，太大了所以
   chmod 700 /root/.ssh/id_rsa

ceph的所有者和所属组在计算机重启后会复原，所以要把 chown ceph.ceph /xx*写到/etc/rc.local


cluster day5
///////////////////////////////////////////////////////////////////////
将虚拟机安装到ceph中，改avpc1.xml文件时，uuid忘了，可以找出来，而一般来说，virsh --help 可以查找
virsh --help | grep secret

kvm想用ceph，还另需要一个账户？ 秘钥就是node1的秘钥？

描述一个数据信息--元数据
[root@client ~]# df -i
[root@client ~]# ll -i iii.txt 
67157089 -rw-r--r-- 1 root root 0 10月 12 14:52 iii.txt 这些就是元数据

ceph环境
1.ssh-copy-id
2./etc/hosts
3./etc/chrony.conf

128PG 是128个文件夹

linux支持ceph文件系统

创建了ceph文件系统后，怎么删除？


day6 实验课
///////////////////////////////////////////////////////////////////////
day5de radosgw还占用着80端口
ss -nutpl | grep 80
kill -9 xxx（pid号)
但是这个程序会保证总有一个进程相应系统，所以杀光进程后，会再起，
所以还是要systemctl stop


haproxy 配置文件中
listen   是一种模式
frontend 比listen能配置更多的需求
backend  指定后端

stats uri /admin 访问健康检查的路径

注意：如果是调度mysql或者是别的那么 mode要改成tcp!!

---->
lvs haproxy nginx

lvs没法做业务区分(html php),

nginx 功能最多的

公司里常用lvs-DR模式
nginx一般做网站服务器，为什么不用其做集群？

DAS NAS SAN 都是存在一台机器上

数据库适合直连式存储

改密码：
echo "xxxxx" | passwd --stdin xxx


补operation day7
///////////////////////////////////////////////////////////////////////
vpn可以使一个公司再部同城是的子公司，想局域网一样通信。
linux内核本身也是模块化的，有些功能没启。
/lib/modules/3.10.0-693.el7.x86_64/kernel/ 这里都是内核里可以加载的模块。
ifconfig xxx xxx 绑定ip
ip addr add xxx  
修改配置文件
这些效果都差不多？

p a s tun0

ip a s 与 ifconfig 与 ip addr 有什么区别？

rpm -qc xxx 可以看软件的配置文件在哪

rpm -ql xxx 可以看安装的软件的所有文件在哪

windows 的注册表regedit就相当于linux的内核

丁大神经过实验验证要注释掉 crtscts lock。

rpm -qc xxxx 这也行?
ql看所有文件，qc看配置文件

rhel.pool.ntp.org比较慢，因为在外国，是标准的红帽的。
国内的阿里的等等等。

192.168.4.1/24这个在时间同步的配置重表示192.168.4.0整个网段？

闰秒？没有固定时间..? 闰秒要提前几个月把服务器停一下?


pssh -x '-o xxxxxxxx' 意思是：
如果一个脚本：
a.sh
#!/bin/bash
ssh $1 192.168.4.xx
$1的位置要传参数-o Stxxxx(不询问yes/no)以便防止问yes/no，然而直接./a.sh -o Stxxx 这样是不行的。所以要用-x '-o Stxxxxx'


数据库 dba day1
///////////////////////////////////////////////////////////////////////
mysql> system bash    !!!!!
卸载包的时候不要用yum卸载，因为这样会把依赖包都卸载了，所以要：
rpm -e --nodeps xxx   这样只卸载当前包

rpm -Uvh xxxxx  ?

mysql.sock 在服务启动的时候才有，是客户端访问mysql的什么什么...? 

主配置文件 日志文件 socket文件 PID号文件 数据库目录的位置 进程所有者和组 数据目录所有者和组

mysql默认只允许自己访问自己，也就是不允许其他的机器访问。

grep password /var/log/mysqld.log 找初始密码

SQL 结构化查询语言
语法规则：
分号结尾
\c 取消命令
命令不去分字母大小写
默认不支持tab建，只有一小部分可以tab

[root@50 ~]# mysql -hlocalhost -uroot -p'uB>mdS.g-3+c'
mysql> alter user root@"localhost" identified by '123qqq...A'; 改密码。
mysql> show variables like "%password%"; 查看变量，%通配符，包含password的变量。
mysql> set global validate_password_policy=0;   设置成不检查复杂度
mysql> set global validate_password_length=6;   设置密码长度

[root@50 ~]# mysql -hlocalhost -uroot -p123qqq...A -e 'select * from mysql.user'
这样直接在外面执行sql命令。

[root@50 ~]# vim /etc/my.cnf  可以把配置永久保存在配置文件中。
validate_password_policy=0
validate_password_length=6
[root@50 ~]# systemctl restart mysqld
但是刚装好包的时候不能先写到配置文件中改，不然服务会起不来。

客户端是如何把数据存储到数据库服务器上的？
1.链接数据库服务器：管理员直接在命令行下登陆，程序员写网站脚本
2.创建数据库：库就是文件夹

直接在/var/lib/mysql下面mkdir一个目录，在mysql中show databases;就可以看到。但是里面没有db.opt啊？

表对应文件

mysql> insert into haha3.t1 values('tom',22,'bj'),('jim',23,'sz');

mysql> update haha3.t1 set age=20 where name="jj";

系统命令建的文件夹，是没发往里面建表。
[root@50 mysql]# mkdir haha
[root@50 mysql]# ls -ld haha
drwxr-xr-x 2 root root 6 10月 15 15:24 haha
因为系统命令建的文件夹所有者和所属组是root，mysql程序的用户和组是mysql，对这个文件夹是其他人，没有写权限，所以chown mysql:mysql haha，改所有者组，或者加权限即可。

照片，电影也是可以往数据库里存的，可以存陈大文本类型text blob但是，取慢，很少这么存

varchar 是多少字符分多少字符，char是定长，但是varchar慢。现在一般是用空间换时间。

默认下char是1，varchar必须指定宽度。

persondb库里创建bogperson表储存前任信息。

表里的int(x)是显示x宽度，插入的长度比x长，正常显示，不足x则用空格补位。



dba day02
///////////////////////////////////////////////////////////////////////
key 键值
按照一定的算法的索引
写到硬盘的文件中
写入较慢。
查bob，看索引bob再第10行，直接去第10行找
如果没有索引，就从头找，找到位置。

主键的值是避免重复..？
如果把一个字段设置成了主键，那么以后在下面存值不可以重复，不可以是空值。

复合主键--表中多个字段一起做主键。多个字段的值不允许同时重复
| 192.168.4.5 | 20   | allow  |
| 192.168.4.5 | 22   | deny   |
| 192.168.4.6 | 22   | deny   |
如上，如果192.168.4.5:20与192.168.4.5:20又被allow又被deny则矛盾了：
| 192.168.4.5 | 20   | allow  |
| 192.168.4.5 | 20   | deny   |
| 192.168.4.6 | 22   | deny   |
这样不可以，所以设置IP+端口设置成复合主键，两个不同时重复就行。

pri+auto_incremen 赋值null是可以赋上的，接着最大的开始。

删除主键和auto_increment后，怎么添加回来？

外键：
如果想建一个工资表，但是工资表的name一列要参照另一个表，即员工表，因为工资表上有员工表没有的人名，那不行。这时候就需要外键，让工资表的name参照员工表的name。
名字有可能重复，所以用员工编号。

r1:num(primary)-name
w1:num(foreign->r1(num))-pay
if wanna add auto_increment to r1(num),can not
first should delete foreign key on w1,then can add auto_increment to r1(num).

auto_increment是建立在主键之上的。
auto_increment可以通过modify增加。
foreign key 存在时，可以增加主键，无法增加auto_increment。
foreign key 存在时，无法删主键。

primary key auto_increment 如果删除表内容，那么再insert，主键值不会从1增长，会继续之前的增长。如果想从1增长，那么删除增长和主键，再添加主键和增长即可。

dba1  mysql day3
///////////////////////////////////////////////////////////////////////
连接池
sql接口
parser 分析器
optimizer 优化器
cache&buffers 查询缓存，有客户端访问先从缓存里查找
存储引擎
文件系统
管理工具

show create table xx 可以看建表时候的默认的引擎

访问表的时候存储引擎开始工作

show engines;

mysql create table后，在工作目录下会生成几个文件
myisam引擎--xx.frm--储存表结构 xx.myd--存数据 xx.myi--存索引

innodb---xx.frm-存储结构 xx.idb-存数据和索引
ibdata1 ib_logfile0 ib_logfile1 事务日志文件

表级锁：给整张表加锁
当有人访问一个表，不管哪一行，就把整张表锁上，再有人来访问就访问不了了。
行级锁：
当有人来访问，只把他访问的那几行锁上，别人来访问就那几行访问不了。
事务：一次操作的过程，
如上银行存钱，转账，从你这转到他那，如果他没有接受，你的钱不够等都会造成转账失败，如果支持事务回滚，则可以退回到未转账前的状态。

mysql> show status;
mysql> show status like '%lock%';

想在mysql下测试事务回滚，先关掉自动提交
show variables like "%commit%";
set autocommit=off;
状态1--命令命令，只要没有commit，那么
rollback
会到了状态1

隔离性：再登一个客户端查查看。不过此时查询，autocommit还是开的

读操作多的最好用myisam，可以节省cpu资源。
因为有人读，就把整个表锁上，就锁一次，第二个客户端来了，还是可以访问，以为读锁是共享锁。而innodb是行锁，来人访问，锁一行，来一个锁几行，锁多次，所以最好还是myisam。

写操作多则用innodb好

show variables like " secure_file_priv";

mysql> select name namehaha,uid uidhaha,homedir homedirhaha from t1 where shell="/bin/bash";
这样可以给选择出来显示的列起个别名。

先执行与后执行或

表里有:
name=null
name="null"
name=""

mysql> select distinct name,uid+5 from t1 where uid<=10;  这样可以
mysql> select distinct name,uid=uid+5 from t1 where uid<=10; 这样就不可以


dba1 day04
///////////////////////////////////////////////////////////////////////
mysql> select id,shell from t4 where uid in (select name from t5);
+----+-----------+
| id | shell     |
+----+-----------+
|  1 | /bin/bash |
+----+-----------+
为什么会有值？

mysql的用户和权限存在mysql.user表
desc mysql.user第3行开始都是权限。

mysql.db 记录用户对库的访问权限

   mysql.sys用户 是初始化后建立的用户

mysql.tables_priv 记录用户对表的访问权限

mysql.columns_priv 记录用户对字段的访问

mysql> grant all on *.* to mydba@"%" identified by "123456" with grant option;

mysql> help create user  可以看帮助

为什么要给mydba授权-可以给他人授权的权限?

information_schema库实在内存中的，假库，储存服务的一些参数

GRANT SELECT,delete, INSERT, UPDATE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE ON *.* TO 'mydba'@'%' WITH GRANT OPTION 
这些权限都要背下。


mysql> grant all on d3.* to admin@"%" identified by "123456" with grant option;
如果创建这样一个用户
再让这个用户创建并授权其他用户(就算权限比自己小)，也是不行的。
因为这个用户对mysql库没有权限，没法写入数据。
然而给这个用户添加mysql权限，只添加insert权限即可.

在撤销权限的时候，怎么添加的，就要怎么撤销，
grant all on *.* to admin@"%" identified by "123456" with grant option;
revoke all on mysql.* from admin@"%";这样撤是不行的。
revoke all on *.* from admin@"%";只能这样撤。

为啥
grant all on *.* to root@"192.168.4.0/24" identified by "123456";
这样添加后，从192.168.4.50访问192.168.4.51还是不行？而
grant all on *.* to root@"192.168.4.0/24" identified by "123456";
这样可以？


dba1 day05
//////////////////////////////////////////////////////////////////
物理备份，拷贝库和表的文件。
/etc/my.cnf 中的语句的意思是，当启动mysql时，会加载datadir=/var/lib/mysql，没有的话，启不来。

逻辑备份，备份的是命令

拷贝，移动来改文件夹名的时候会出现问题！！

注意给目录添加权限

mysql -uroot -p123456 d5 t1 < xxxxxx  这样是先删表，再恢复？

默认500M后，自动创建一个新的日志文件

但是我不想等500M：

可以在完全备份后，重新建一个binlog文件
mysqlbinlog -uroot -p123456 --flush-logs db5 > /root/db5.sql

rpm -ql percona-xtrabackup-24 这样查
man innobackupex

innobackup 备份，有一个xxxbin_xxx 这里面记录的是备份的最后一条备份时，备份库的节点?所以说mha，用innobackup恢复还是比较靠谱!

备哪一行，锁哪一行

innobackupex 完全备份想要恢复，首先要把/var/lib/mysql/*全删了。

日志序列号（事务日志）
只有innodb引擎有事务日志序列号
[root@50 ~]# cat /new2bak/xtrabackup_checkpoints
backup_type = incremental
from_lsn = 5450846
to_lsn = 5460377
last_lsn = 5460459
compact = 0
recover_binlog_info = 0
根据上一次的序列号来增量备份。

innoback增量恢复后，所有内容都在fullbak里了

innobakup恢复表的时候，如果想复制恢复，那么日志和数据都要拷过去。


dba2 day01
//////////////////////////////////////////////////////////////////
主从同步
主库启用binlog日志，丛库的sql线程从主的binlog日志读命令记录到丛库的中继日志，丛库的io线程执行中继日志的命令。

mysql> show master status; 可以查看master的日志和偏移量。
想改slave的化：
看slave status的报错信息
stop slave
change master to master_log_pos=xxxx;
如果密码错了改密码，

slave的master_log_pos可以选在 master grant replication slave前，也可以选在其后。

如果有uuid报错，则改一下/var/lib/mysql/auto.cnf中的uuid。
这种报错一般出现在：直接将猪服务器上的mysql直接复制过来，把自己原来的都覆盖了，uuid也覆盖了，这样slave就认为自己的uuid与master的uuid一样了。

临时关掉52，51写数据，53同步了，再打开52，52还是会同步过来。

52中有两个日志，一个是52-bin.000001（binlog日志），一个是52-relat-bin.000002（中继日志），
如果是做slave同步，那么52-bin.000001的节点是不变的。

如果想还原slave到普通服务器那么：
停服务然后：
删掉master.info
删掉xx-relay-bin.* 日志和索引
删掉relay-log.info
重启服务

备份
指定

主主结构：
不需要指定：log_slave_updates.
为什么有人两个mysql上都有两个repluser用户，而我54上只有slaveof54的用户，55上只有slaveof55？


dba2 day02
//////////////////////////////////////////////////////////
如何52只同步51的bbs库，53只同步51的game库？

异步同步：用户使用后，立刻反馈用户，不管丛库是否同步完。优点快，缺点如果主坏了，用户访问从库可能找不到完整数据。
同步同步：所有丛库全同步完再给用户，有点完全，缺点慢。
半同步同步：保证一个丛库同步完，告诉给用户。

搜索 组同步复制,就是同步复制 可以找到配置方法。

配置半同步：
要加载一个模块
看看能不能动态加载模块
show variables like "have_dynamic_loading";

monitor要监视两个server2的数据库状态，主从连接状态，主从同步状态。
注释掉只读服务。

 64 [Read-Write Service]
 65 type=service
 66 router=readwritesplit
 67 servers=server1,server2
 68 user=myuser  
 69 passwd=mypwd
 70 max_slave_connections=100%
68和69行的用户是：
客户连接53，53转接51和52。maxscaled是给53用的，用来检查51和52上有没有客户端用来连接自己的账户。
scalemon也是给53用的，是用来监控的，监控服务。
webuser是客户端用的访问用户。
需要3个用户

scalemon监控52,53，看谁是主谁是从，把读给从，写给主。这样实现读写分离。给scalemon的授权要授对。

select @@hostname看主机名。

停掉mysqld_multi，也可以用kill -9 ...
kill -9 跟的是进程pid号
pkill -9 跟的是进程名

lsof 是将进程打开的文件都列出来
lsof -i:22 看22端口的


读写分离的时候 要server1,'空格'server2 ？


性能调优：

show variables; 是看系统的所有变量。
show globlal status; 是看当前运行的参数。

[root@51 ~]# uptime 其中在线时间可以用来吹比。
查询缓存是从物理内存中划分出来的。

mysql> show variables like "%conn%";

max_connections          151
mysql> set global max_connections=300;

Max_used_connections     11
mysql> show global status like "%conn%";

曾经有过的最大连接/max_connections=0.85，这样来设置max_connections的值比较好。

mysql> show processlist; 看当前谁在连着。

connect_time 三次握手超过这么长时间，就断开。

wait_timeout 不能设置得太短。

.MYI索引信息会放到内存里。

table_open_cache 一般表被访问时，先从硬盘被放到内存里，然后访问，访问结束后再放回硬盘。table_open_cache=2000，则表北方问候不用被放回硬盘，最多2000个。

mysql> show variables like "query_cache%";查询缓存，query查询。

优化程序员的sql命令。
general-log 记录所有的命令。51.log

慢查询日志？

满查询日志的统计：
mysqldumpslow /var/lib/mysql/51-slow.log > haha.txt 把着个发给程序员，让他优化。


dba2 day03
//////////////////////////////////////////////////////////
51 52 53把主的半同步和从的半同步都开了，因为都有可能做主和备。

设置成不自动删除中继日志

mha使用perl(一个脚本语言)写的

echo $PATH

mha 是要有一个虚拟ip的!

master_ip_failover 只负责切换，不负责初始部署。所以给51绑一个vip。
ifconfig eth0:1 192.168.4.100/24
ifconfig eth0:1 down 这样可以删除

记得51-55上也要装mhaxxxxnote。

当掉51，然后52成了主库，怎么恢复？
启51
手动把51配置成52的丛库
然后添加server到/etc/mha/app1.cnf
remove_dead_master_conf的意思是，51作为master坏了，就把51从app1.cnf中删除
看来51宕机期间的数据，要自己弄过去,可以用binlog日志恢复。

是根据binlog日志生成的时间来判断谁与master最接近。所以再把51添加回来后，停掉52，这时候51会变成master，就算对53flush logs也不行，这是为啥？

要至少三台同时做集群，才给切换master。如果51停了，再挺52就不给切到53了。what?? it is changed whatever!?

人肉读写分离，还有别的办法么？


dba2 day04
//////////////////////////////////////////////////////////
不希望所有用户都能看到表里的所有内容，不同用户看到的表里的数据是不一样的。

视图是一个假表

view 多表查询，创建join，名不能重复？

字段不能重复，是唯一的。

具体化方式？
建立view时候有个select，查询的时候本来只查询一下view表就行了，但是在查之前要执行一遍建立表的着个select一下。，
替换方式？
只查表。

create xxxxx where uid>25 with local check
update xxxx set uid=7 报错
update xxxx set uid=30 可以

基表也可以是视图表。

那么如果并不像让人通过视图修改基表，要怎么做？


存储过程
1.要改提示符 ; --->别的如//，不过应该可以不用吧?
2.要指定再某个库下。

会话变量，只对当前用户有效。

自定义变量要加 @，调用也要加 @。
procedure里的 in out inout型参数不用加 @；
procedure里用declare x int;调用x也不用@；
但是procedure里也可以定义set @x=2;这是定义了一个会话变量？

存储过程是一段编译好的代码，效率更高。


dba2 day05
//////////////////////////////////////////////////////////
mycat解压后，conf目录中的是各种配置文件，rule.xml是分库分表的算法对应的配置文件。不同函数对应的方法在一个文档中。

wrapperlog里的是日志。

mycat分片要加上mamcache缓存服务器，不然查询慢。

1.要有<schema>
2.schema里面要定义表模板
3.dataNode里的库db1要在mysql上真实的建出来。但是到mycat中就是逻辑库TESTDB。

mycat 前端假装自己是个mysql,所以前端要有库，用户名和密码。
server.xml 读写的用户 只读的用户

dataNode是虚拟服务器。

后端将请求转发给mysql,后端有负载均衡加健康检测
健康检测用：<heartbeat>select user()</heartbeat>
swictype 自动切换？

读写分离和数据分片不用配到一起，生产环境分业务，写多的业务用数据分片，读多的用读写分离。
1.6-release可以配置多组主从

mysql数据拆分，x,y,z三个方向：
x 水平扩展---读写分离
y 按业务 


有一个mydb.sql库，怎么把其导入？
mysql> source mydb.sql


nosql day01
//////////////////////////////////////////////////////////
mysql   oracle   sql server 关系型数据库，都要了解下。
关系型数据库要先建表，要有一定的组织结构。表和表之间可以做关联操作。

没有指定ip时，默认只能127.0.0.1来连接,127.0.0.1只能与本机通信，所以默认只能本机访问。

-1是永不过期。

shutdown后，关服务，同时将数据写到硬盘。

[root@50 redis-4.0.8]# vim /etc/redis/6379.conf

改配置文件的port，地址127.0.0.1-->

改完之后再用自带的脚本停服务就停不掉了
[root@50 redis-4.0.8]# redis-cli -h 192.168.4.50 -p 6350
192.168.4.50:6350> shutdown
[root@50 redis-4.0.8]# redis-cli -h 192.168.4.50 -p 6350 shutdown

或者修改自带的脚本。

tcp-keepalive 300 每300秒发一个确认，客户端答应了，就不断开连接。

grep -i 忽略大小写。

[root@57 phpredis-2.2.4]# ls /usr/lib64/php/modules/
curl.so      mysqli.so     pdo_sqlite.so  zip.so
fileinfo.so  mysql.so      phar.so
json.so      pdo_mysql.so  redis.so
mbstring.so  pdo.so        sqlite3.so
php-redis装好后，以模块的形式存放


nosql day02
//////////////////////////////////////////////////////////
16384个hash槽，用槽存储数据
丛库没有hash槽
crc16算法
通过不同的hash槽来区分存到哪里。
添加新的master后，也要重新分hash槽。
重新分hash槽，数据也会被分过来.
[root@50 mysql-5.17]# vim /var/lib/redis/6379/nodes-6350.conf  集群配置信息写在这个文件中。

启了集群配置后，存数据取数据就会调用crc16算法，那么存取的时候就会有故事

slave被移除后，数据还在，但是因为cluster配置还在，所以get不到数据的值，所以要注释掉mcluster配置和删除node-xxxx.conf，重启服务，再get。

主库被从cluster移除后，hash槽也被移除了，所以也没有数据了。

删除掉的主机想再添加回来，因为移除后，node-xxxx.conf还在，所以会报错，说集群主机还在，所以要删除node-xxxx.conf然后重启，再添加。还可以进到57的redis里，cluster reset

如果集群中有一对主从都挂了，那么数据不完整了，整个集群也挂了。所以一个主库，两个丛库比较好。



11.1
//////////////////////////////////////////////////////////
注意  expect 默认最后一个expect不执行，所以...


nosql day03
//////////////////////////////////////////////////////////

想永久配置主从，把282行修改一下，ip和端口。如果主库有密码则改一下289行

哨兵模式？多票数？怎么操作？

一主一从，一个哨兵不可靠，所以要一主两从，
A：主 哨兵 监控A
B：从 哨兵 监控A
C：从 哨兵 监控A
票数：2
哨兵的配置文件中，与别人通信的地址要修改。bind xx.xx.xx.xx
然后程序员要连那一台要自己判断。
redis哨兵+keepalive(vip)呢？

端口6379，启服务就是redis-sentinel /etc/sentinel.conf
jobs看进程，后面加& 回车回车 放到后台，fg后台的调到前台。ctrl+c停了。

rdb存储模式，在配置文件中有参数
aof模式，相当于mysql的binlog日志。

想要恢复redis数据，先shutdown。

重启服务才重新加载dump.rdb

rdb宕机前最后一次数据存不上。

aof和rdb都启的时候，先加载aof。

redis脚本启服务的时候，会先建一个pid号文件，redis_63xx.pid。当启动redis后，发现aof文件损坏，然后修复aof文件，再启动，就报错了，因为pid号文件一斤生成了。所以要先删掉这个文件，然后再重启。


nosql day05
//////////////////////////////////////////////////////////
mkdir -p xxxxxxxx
如果是用文件的配置项启动服务，那么就用 -f /xx/xxx.conf

127.0.0.1只能本机访问

alias

vim /root/.bashrc
alias mongostart='/usr/local/mongodb/bin/mongod -f /usr/local/mongodb/etc/mongodb.conf'
alias mongostop='/usr/local/mongodb/bin/mongod --shutdown -f /usr/local/mongodb/etc/mongodb.conf'
启动停止mongodb定义一个别名

mongodb导入：
不能指定字段_id导入，因为不能有两个字段?




mysql_1 mysql_2 直连式存储

day05
//////////////////////////////////////////////////////////
replSet=rs1 写到配置文件中

配置文件：
logpath=/usr/local/mongodb/log/mongodb.log
logappend=true
dbpath=/usr/local/mongodb/data/db
fork=true
port=27051
bind_ip=192.168.4.51
replSet=rs1

config_1={_id:"rs1",members:[{_id:0,host:"192.168.4.51:27051",priority:10},{_id:1,host:"192.168.4.52:27052"},{_id:2,host:"192.168.4.53:27053"}]}

加上priority,设置主从的权重。

地址池？

可以用keepalive(虚拟ip)+mongodb，用虚拟地址链接，防止主坏了而连上丛库，或者地址池。

把replSet=rs1注释掉，然后重启服务，然后再删除集群信息。拆。


security day01
//////////////////////////////////////////////////////////
/etc/skel/ 目录下是用户初始配置文件，每当一个新用户建立，系统就会把这个目录下的文件拷贝到其家目录下。
将Nginx放到这个目录下，那么每创建一个新用户，系统就会也将Nginx考到其家目录下，所以可以将我想给他的文件考给他。

chage -d 0 admin2
效果是，当以admin2登陆后，要首先改密码。
chage --help

cal调出日历

grep -v '^#' /etc/login.defs 不显示注释行
密码设置策略

passwd -u admin2 解锁密码

进公司后先看系统的别名！命令要先用\取消别名用。

把/etc/issue的删掉，在真机命令行登陆再退出，就不显示版本号了。

[root@50 ~]# lsattr /etc/passwd 看有没有特殊属性

[root@50 ~]# chkconfig httpd on   rhel6设置自启
[root@50 ~]# chkconfig httpd off  设置开机不自启
[root@50 ~]# service httpd status 看服务状态
chkconfig list ??

[root@50 ~]# su admin2          不加-环境不变
[admin2@50 root]$        
[root@50 ~]# su - admin2        加- 环境也变
[admin2@50 ~]$ 

tailf /var/log/secure 可以看登陆信息和用户切换信息。

rpm -e --nodeps elinks 不删除依赖包的删除

/etc/group 里的是组信息

groupadd xxgroup

usermod -G xxgroup jack 是这样添加？

groupadd -g 200 g1
useradd -u 200 -g g1 u1

useradd -u 200 -g g1 -r u1 这样是创建系统用户，没有家目录..

可以这样创建用户和添加组
[root@51 ~]# useradd lili
[root@51 ~]# echo 123456 | passwd --stdin lili
[root@51 ~]# groupadd dbagroup                  创建组
[root@51 ~]# gpasswd -a lili dbagroup           将用户添加进组
[root@51 ~]# gpasswd -d lili dbagroup           将用户删除出组
各种信息在下面的文件中
[root@51 ~]# vim /etc/group
[root@51 ~]# vim /etc/gshadow
[root@51 ~]# vim /etc/shadow
[root@51 ~]# vim /etc/passwd

50主机-->51的root,51上有lili用户
[root@50 ~]# ssh-copy-id root@192.168.4.51
51主机把公钥考到lili的家目录.ssh/
[root@51 ~]# cp .ssh/authorized_keys /home/lili/.ssh/
然后50主机远程51的lili
[root@50 ~]# ssh -X lili@192.168.4.51 结果并不能秘钥登陆
这是因为root拷authorized_keys到lili的家目录下，authorized_keys的所有者和所属组还是root，lili并没有权限使用这个公钥！
所以:
[root@51 ~]# chown lili:lili /home/lili/.ssh/authorized_keys 


]# ssh-keygen -b 2048 -t rsa -N '' -f thekey
]# ssh-copy-id -i ./thekey.pub root@192.168.1.22
-b: 长度 -t ?  -N 密码(无)  -f: 路径和名字 默认是~/.ssh/id_rsa

[root@51 ~]# ls /root/.ssh/
id_rsa  id_rsa.pub  known_hosts
51生成秘钥，公钥是id_rsa.pub,私钥是id_rsa

[root@50 ~]# ls /root/.ssh/
authorized_keys  id_rsa  id_rsa.pub  known_hosts
51把公钥传给50,50将改公钥存放再authorized_keys。
51远程50时候，51用authorized_keys里的公钥加密密码，传给51，然后51用私钥解密，然后连接。

50上 PasswordAuthentication yes --> no  这样禁用口令登陆(密码输入登陆)

selinux :
disabled,permissive,enforcing 相互改变的化，只能一级一级的改。

ps auxZ | grep -i xxx  看进程的selinux策略

[root@50 ~]# setenforce 1
[root@50 ~]# ls -lZ /var/www/html/*.html
-rw-r--r--. root root system_u:object_r:httpd_sys_content_t:s0 /var/www/html/1.html
-rw-r--r--. root root unconfined_u:object_r:admin_home_t:s0 /var/www/html/2.html
-rw-r--r--. root root system_u:object_r:httpd_sys_content_t:s0 /var/www/html/index.html
这样51可以访问1.html，访问不了2.html

mv一个文件是继承原来的selinx上下文，cp是继承拷贝到那里目录的selinux上下文

[root@50 ~]# chcon -R -t httpd_sys_content_t /var/www/html 递归修改

[root@50 ~]# setsebool -P zoneminder_run_sudo on


要想连接ftp，服务端要有vsftpd，客户端要有ftp包。
ftp ip    匿名用户ftp  无密码登陆。
如果想让其他人可以往ftp上上传文件，那么/var/ftp/sharedir得有o+w权限。里面的文件相认别人下载，也要有rrr权限。
配置文件/etc/vsftpd/vsftpd.conf中，解开注释，允许匿名上传：
 29 anon_upload_enable=YES
 30 #
默认监听ipv6
/etc/vsftpd/vsftpd.conf 中listen yes   listen ipv6 no


就算服务即配置对了，selinux的策略对了，如果sebool值关着，那也访问不了。

selinux的监控程序包 setroubleshoot
/var/log/messages访问日志的报错消息都在这个文件里。
一旦有违反了selinux规则的操作，报错信息就在那里。

security day02
//////////////////////////////////////////////////////////
[root@room9pc01 ~]# dd if=/dev/zero of=/a.txt bs=1M count=10240 对磁盘进行写操作，  cat a.txt

[userb@room9pc01 ~]$ gpg -a --export sdfsdf > /tmp/gpg/pub_userb.pub  老师讲的时候，--export 后面并没有加东西。加秘钥的用户也是可以的。

如果用户是sdfsdf，那么客户端加密的时候
[usera@room9pc01 ~]$ gpg -e -r sdfs 1.txt 这样加密也可以！？ sdfsd sdf 都可以！?
可以生成多个秘钥，但是私钥公钥都放到哪里了？

aide是一个程序，不是一个服务
/var/lib/aide/aide.db.new.gz 这个还是要拷贝走一份，免得被别人攻击了删掉，就无法对比了。

99行到312行都注释了，然后自己定义检测目录和检测算法。

使用tcp协议的服务，在建立链接的时候要经历三次握手
半开式扫描，就是客户端，不回第三次的握手。可以进行拒绝服务攻击，因为服务端要等待第三次握手。

[root@room9pc01 ~]# nmap -sP 192.168.4.30-130 扫一个范围

抓包：
只有包经过自己的电脑，才能抓到包。
如果不指定，默认抓eth0的包。

src源地址，dst目标地址

[root@50 ~]# tcpdump -i eth0 -A -c 1 -w ssh.cap tcp port 22
[root@50 ~]# tcpdump -A -r ssh.cap 
[root@50 ~]# tcpdump -i eth0 -A -w ssh.cap tcp portrange 10-1000 and host 192.168.4.53


wireshark 第一大栏：都抓了那些包
第二大栏：每个包的7层协议
第三大栏：具体数据

工作后经常要用。


security day04
iptables 防火墙
//////////////////////////////////////////////////////////
[root@50 ~]# service iptables start
[root@50 ~]# service iptables status
[root@50 ~]# chkconfig iptables on

主机型 网络型

哪张表有什么链是固定的。

PPT上有个问题：nat表还有INPUT

默认规则是ACCEPT

默认策略只有ACCEPT或DROP

[root@50 ~]# iptables -t filter -A INPUT -p icmp --help

arp -n 可以看记录的ip和对应的mac地址

ping 走的 icmp 协议

[root@52 ~]# iptables -t filter -A FORWARD -p icmp --icmp-type echo-reply -j ACCEPT 
[root@52 ~]# iptables -t filter -A FORWARD -p icmp --icmp-type echo-request -j ACCEPT 
其实上面两个写成下面一个即可。
[root@52 ~]# iptables -t filter -A FORWARD -p icmp -j ACCEPT 

公司里都是用防火墙实现私网ip转公网ip？

[root@52 ~]# iptables -t nat -A POSTROUTING -s 192.168.4.0/24 -p tcp --dport 80 -j SNAT --to-source 192.168.2.52 这样操作之后，在"公网"主机上查看access_log（如果是httpd，/var/log/httpd/access_log），可以看到被转换后的地址的访问记录


security day03
//////////////////////////////////////////////////////////
堡垒主机？

把审计写到规则文件中，/etc/audit/rules.d/audit.rules，文件中之前的内容删不删除？

nginx 配置文件中 server里，加上 autoindex on;
nginx -s reload

nginx的html中建立test目录，写三个文件。如果只访问test，那么就会看到test中的所有内容，这样很不安全。

nginx -t 可以测试语法错误

拒绝非法访问中：444不是一个标准的状态码，500等这些是标准的。写入500再访问，就会出现50


多次并发访问，每秒处理1个信息，处理一个，剩下的5个放到内存里，再来就直接扔掉了。

ftp下载目录
[root@room9pc01 myfiles]# wget -r ftp://176.204.13.13/soft/电子书 --ftp-user=Nsd1807 --ftp-password=Nsd1807

history -c 清除历史
history -w 把历史记录写进 ~/.bash_history
> .mysql_history 直接写入文件也可以的

mysql默认是用明文传输的，如果被抓包，则可以看到。所以要给mysql加密。

jar -xf catalina.jar 在当前目录生成了org

添加tomcat用户，然后用tomcat启动tomcat
用 ps aux | grep -i java 可以看到第一个进程的所有着是tomcat

有时候光给 /etc/rc.local 加执行权限可能不管用，其所指的 /etc/rc.d/rc.local 也要加执行权限。

tree可以看目录的树形结构
yum -y install tree

patch打补丁，注意路径问题！


security day05 zabbix
//////////////////////////////////////////////////////////
系统跟的监控命令：
ps
uptime
free
swapon -s
df -h
ifconfig
netstat 或 ss
ping
traceroute
iostat

SNMP?

CS zabbix 被监控的是客户端。

./configure --prefix=/usr/local/zabbix --enable-server --enable-agent --with-mysql --with-net-snmp --with-libcurl
ppt上没有指定安装路径

--enable-agent 装这个包是因为也要监控自己
--enable-proxy 是如果不同地方的监控

访问 要访问： 192.168.4.5/zabbix/index.php

[root@5 php]# /etc/init.d/zabbix_server status 这样可以看为什么zabbix服务没有起来

但是页面有错误应该是nginx,mariadb,php-fpm没有配好
没有连上数据库

初始化配置都写到这里，以后可以修改这里
[root@5 php]# vim /usr/local/nginx/html/zabbix/conf/zabbix.conf.php

启动服务的脚本
[root@5 zabbix-3.4.4]# cp /root/lnmp_soft/zabbix-3.4.4/misc/init.d/fedora/core/zabbix_server /etc/init.d/

日志文件被放到了/tmp下。

agent配置时候：
ServerActive=127.0.0.1:10051 这里有个端口号
非本地主机的SercerActive=127.0.0.1,192.168.4.5:10051也要加个10051
Include=/usr/local/zabbix/etc/zabbix_agentd.conf.d/*.conf 路径安装目zabbix

登陆网页，可以添加模板

自定义监控：4.200上zabbix_get命令可以用来监控本地的用户数量：
vim /usr/local/zabbix/etc/zabbix_agentd.conf.d/usernum.conf注意文件后缀
UserParameter=usernum,wc -l /etc/passwd | awk '{print $1}'
自定义监控命令后可以查看：
[root@200 zabbix-3.4.4]# /usr/local/zabbix/bin/zabbix_get --help
[root@200 zabbix-3.4.4]# /usr/local/zabbix/bin/zabbix_get -s 127.0.0.1 -p 10050 -k usernum
而监控服务器4.5也可以通过zabbix_get命令远端监控4.200的用户数量。
[root@5 init.d]# /usr/local/zabbix/bin/zabbix_get -s 192.168.4.200 -p 10050 -k usernum
42
将这个命令写到监控模板里即可，一调用监控模板就调用该命令

因为自己安装zabbix的时候，指定了安装目录，所以/etc/init.d/zabbix_server(zabbix_agent)中22行的地方最后要加个zabbix。/usr/local/zabbix/etc/zabbix_agentd.conf agent的配置文件中265行中间也要加一个zabbix。

security day06
//////////////////////////////////////////////////////////
邮件提醒报警，用户是zabbix，地址是zabbix@localhost
要先配置一下本地的邮件服务。

把本地的主机名写到/etc/hosts里：（以免没有被识别？）
127.0.0.1   h5 localhost localhost.localdomain localhost4 localhost4.localdomain4

本地邮件服务端口是25，如果没开启，则：
[root@h5 ~]# systemctl restart postfix.service 

[root@51 zabbix-3.4.4]# sed -i "22s;/usr/local;&/zabbix;" /etc/init.d/zabbix_agentd 
[root@51 zabbix-3.4.4]# sed -n "22p" /etc/init.d/zabbix_agentd
	BASEDIR=/usr/local/zabbix/agent
这样改不错！

[root@51 ~]# curl -s 127.0.0.1/status | awk '/Active/{print $NF}'  加不加s竟然很不一样！

请求总数，处理的请求数，



cloud day01
//////////////////////////////////////////////////////////
几个9

git clone git://124.193.128.166/nsd1807.git

esxi + vcenter  --> vSphere

所有菜单都点一遍

[root@room9pc01 nsd1807]# lsmod | grep kvm
看内核模块

最底层是kvm，往上是qemu，再上是libvirt,再上是virsh
启动一台虚拟机后，看命令:[root@room9pc01 nsd1807]# ps -efww 可以看到调用了很多硬件命令（总线什么的）（qeum的命令?），libvirt管理这些命令，给用户提供virsh命令。

虚拟网路--虚拟交换机

virsh --help
virsh autostart --help 二阶帮助!!

virt-manager也可以远程链接，但是没有输入密码的地方，所以要先部署秘钥。

virsh # net-dumpxml private1 看private1网络（交换机）的配置信息。

自己创建虚拟网络。
<network>
<name>vbr</name>         名字
<bridge name="vbr"/>     ifconfig看到的名字
<domain name="vbr"/>     net-list看到的名字
<forward mode="nat"/>    使在这个网络的主机可以连公网
<ip address="192.168.1.254" netmask="255.255.255.0">
<dhcp>
<range start="192.168.1.100" end="192.168.1.200"/>   //dhcp的ip范围
</dhcp>
</ip>
</network>

上面的信息存到/etc/libvirt/qemu/networks/vbr.xml文件中然后：
[root@room9pc01 networks]# virsh net-define /etc/libvirt/qemu/networks/vbr.xml   这样让libvirt知道这个网络。
[root@room9pc01 networks]# virsh net-start vbr
[root@room9pc01 networks]# virsh net-autostart vbr

想修改vbr,如果是修改配置文件的化，那么重启系统才生效，因为内存里的信息没有改，所以用命令net-edit可以立即生效。

ip a 可以看ip...


做一个后端盘：
[root@room9pc01 images]# qemu-img create -f qcow2 v0.qcow2 2Gi
这样创建一个空磁盘2G够了，作为后端盘，前端盘再扩容。做完后端盘后，virsh undefine xxx.xml 这样删了虚拟机，但是后端盘还在，这样就不能virsh start 这个虚拟机了，安全性提高。但是还是可以guestmount来修改。

[root@room9pc01 nsd1807]# sed 's,node,v0,' node.xml > /etc/libvirt/qemu/v0.xml

真机：
[root@room9pc01 images]# systemctl stop firewalld
[root@room9pc01 images]# systemctl mask firewalld ？

1.yum源(ppt) 竟然是用yum来装系统！
2.磁盘文件(qcow2格式)(案例)
课堂上讲的是创建了个2G的系统盘，为什么只有2个G?是气球原理，可以吹大？气球原理和写时复制是两个原理？
3.装机(案例)

-->自动分区会用逻辑卷，比较恶心，所以手动分区！？

一个公网的dns服务：202.106.196.115
[root@room9pc01 images]# vim /etc/resolv.conf
# Generated by NetworkManager
nameserver 176.204.0.227
(114.114.114.114)

[root@localhost ~]# yum list | grep bash
bash-completion.noarch   这个是tab建的包

[root@localhost ~]# yum provides ifconfig  可以看那个包提供哪个命令 没有啊？？

重新生成内核引导文件

除了用ip远程连接虚拟机，还可以用console链接，但是装完的虚拟机智能用图形来console连接，所以要改下配置文件。
virsh console centos7.0 用console连接。

NAME="eth0"
ONBOOT=yes	开机启动
IPV6INIT=no
BOOTPROTO=dhcp
TYPE=Ethernet

问题：
1 气球原理和写时复制是不是两回事？
2 yum装机并没有用到yum啊?


gpg ---数字签名
gpgcheck=1是为了安全，一些公司的源，怎么保证没有改过?
检查软件是否有数字签名，如果被动过，数字签名就没了。
公钥再yum仓库的系统盘上，可以先下载下来再导入。也可以ppt.

GRUB_DISABLE_LINUX_UUID="true"
GRUB_ENABLE_LINUX_LABEL="true"
让磁盘的设备名不使用uuid来区分，用磁盘名vda1,vda2来区分。？

vim /etc/fstab  开机自动挂配置文件
/dev/vda1       /                      xfs     defaults        0 0

ifcfg-eth0 =号后面的最好加""

在前端盘进行扩容，后端盘不扩。前端盘不能比后端盘小。

清理日志信息：
关虚拟机
真机执行：virt-sysprep -d node
yum provides virt-sysprep  查命令在哪里

后端盘必须只能是只读的。

[root@room9pc01 centos7]# cd /var/lib/libvirt/images/
[root@room9pc01 images]# qemu-img create -b node.qcow2 -f qcow2 node1.img 16G
[root@room9pc01 myfiles]# cd nsd1807/
[root@room9pc01 nsd1807]# sed 's,node,node1,' node.xml > /etc/libvirt/qemu/node1.xml
[root@room9pc01 nsd1807]# virsh define /etc/libvirt/qemu/node1.xml 
[root@room9pc01 nsd1807]# virsh start node1


要写几个脚本供创建虚拟机后使用：（脚本放到后端盘，但是执行要再前端盘）
1.自动扩容：分区扩容，文件扩容
2.自动配置静态ip脚本


echo "
DEVICE=\"eth0\"
ONBOOT=\"yes\"
NM_CONTROALLED=\"no\"
TYPE=\"Ethernet\"
BOOTPROTO=\"static\"
IPADDR=\"192.168.1.1\"
NETMASK=\"255.255.255.0\"
GATEWAY=\"192.168.1.254\"
" > /etc/sysconfig/network-scripts/ifcfg-eth0

/usr/bin/growpart /dev/vda 1
/usr/sbin/xfs_growfs /

growpart /dev/sda 1
resize2fs /dev/sda1 


修改了后端盘，那么所有的前端盘都要重新做。



cloud day02
//////////////////////////////////////////////////////////
openstak
会自己管理网络,会与NetworkManager冲突，所以卸掉了NetworkManager
会自己管理防火墙，所以些掉了firewalld
需要一个dns服务器
需要一个时间同步服务器

[root@room9pc01 ~]# man named

paas云  淘宝

saas云  应用商店

paas saas云的底层要有iaas云支撑

步骤看视频吧。

1.建两个虚拟机
openstack 9.5G 50G+20G eth0 192.168.1.10 et

一个机器只能有1个网关?

不用loop文件模拟卷组。

卷组的名称子这个版本定死的是cinder-volumes

openstack是用python写的。

rpm -qa | grep xxx   !!


openstack 将各个云主机隔离，以免哥哥公司之间干架。
vxlan隔离每个公司的云主机，但是没法访问外网。所以也需要flat。

单播，组播，广播
组播是在一个组里广泛播。

打通次元技术：
云里的每个主机之间的通讯用交换机，但是如果想与真实机通讯，则：
让真实网卡作为虚拟交换机的一个端口（交换机上有很多口），然后就可以通讯了。

二层虚拟，因为openstack是在真机的虚拟机A上装的，然后又管理虚拟机A-a。所以虚拟机A的eth0就相当于真实网卡。然后eth0堕落为openstack的虚拟交换机的一个端口了。
    Bridge br-ex
	...
        Port "eth0"
这个是出的端口

openstack 用命令管理，就要多看help，初始化source ~/keystonerc_admin后，openstack help

官方下载small.img

云主机类型---xxx.xml文件
镜像---------xxx.qcow2后端盘

出售公有云管理员配好外网

dns: pc: room9pc1: resend dns server
装openstack前，指定dns服务器，/etc/resolv.conf的第一行一定要是：
nameserver 192.168.1.254
如果没有这么做，就装好了openstack，当创建好云主机后，打不开，是1006错误。
于是：[root@openstack ~(keystone_admin)]# vim /etc/nova/nova.conf   8465行，将vncserver_proxyclient_address=openstack.vbr 等号后面的复制到/etc/hosts里面让主机知道这个名字的ip（自己的ip）。然后云主机就起得来了。

指定dns服务器：/etc/resolv.conf ---> nameserver xxx.xxx.xxx.xxx

真机做的是转发dns服务器。


cloud day03
//////////////////////////////////////////////////////////
admin负责建分配总的核数和内存数。

实验的时候openstack起不来，可能是启动openstack的时候内存没够，有些服务没有起来。因为刚启动的时候是要消耗更多的内存的。
把云主机都删了，节省下内存，然后重启openstack，然后再建云主机，基本就行了。
ot@openstack ~]# systemctl list-unit-files | grep -i openstack        看服务

hlat -p  ?? 关机

浮动ip

DPDK ?

4网段的ip有啥用？为啥要俩网卡？

是不是新版本的openstack没有自动安装脚本？

openstack --version
nova-manage --version 看nova的版本，然后就能找到安装的openstack安装的脚本。


cloud day05
//////////////////////////////////////////////////////////
/usr/sbin/semodule:  Failed! 这个可以忽略？

createrepo ./ 这个操作? 在当前目录下创建一个repodata，再写到yum.repo中就可以用了。
createrepo --update . 更新仓库

file xxx

容器是镜像上的实例。

docker --- 进程

看docker的帮助：
man docker
docker image --help

ps -ef
ip a s
echo $$

六个命名空间
文件系统
进程
网络
用户
信号向量： 如杀进程的时候，就是发送一个信号，信号位15就杀死进程，而如果是0则不是。
主机名

yum rpm            redhat
apt-get dpkg       debian ubuntu

docker  --- libvert

docker inspect xx   相当与查看xx镜像的属性
Env下面有环境变量
Cmd是默认以什么启动

tag 名称和标签不能都相同。相当于一个软链接。

docker run  是重新启动一个容器。

ctrl+p q

上帝进程---pid=1的进程，真机中：system
systemctl是给system的命令，所以再docker中，上帝是bash的，就没法使用systemctl，所以要手动启动服务。apachectl 启动httpd。

进入nginx(docker),nginx启动，然后就卡死了，退也退不出来，但是服务还用能。然后关了终端，再stop docker(nginx)，然后docker就死了。

history -c
history -w

守护进程，不放到后台，就会挂在当前屏幕

如果不知道服务怎么启动，那么就去看systemctl启动脚本
/usr/lib/systemd/system/

容器的名字不需要全书写出来 85bc即可

课堂上老师的httpd docker，为什么：
docker run -it myos:httpd 这样就没法启动？启了然后就关了,而且报个乱七八糟的错?-----是因为路由功能没有开启：
[root@ansible ansible]# sysctl -a | grep ip_for
net.ipv4.ip_forward = 0

docker run -itd  myos:httpd 这样就能起来。

物理机相当于一个docker的服务器。

api应用程序接口

写sshd的Dockerfile的时候：
给一个最小化的系统安装sshd服务，yum -y install sshd 然后如何启动?可以看物理机上的/usr/lib/systemd/system/下的sshd.service启动脚本，然后，导入环境变量(ENV)，看看环境变量的文件中都有啥，然后执行启动命令，如果报错，就按照报错安装各种包什么的。没有变量就$OPTION那个去掉。


网络：
一对设备，一个塞进docker，一个留在外面

docker有三种网络类型
docker network list
现在想让docker的 1 2 3通信 4 5通信，123 45间不通信
则可以建两个docker的交换机
docker network --help 
docker network create (--subnet这个参数比较重要，因为是网段，交换机总得有个网段) --subnet 10.10.10.0/24 docker1
在物理机上会显示出br-aeb9ced2d9db这个id
docker run --network=docker1 -it myos:b0 /bin/bash 这样，就是将容器放到docker1交换机中启动了。

自己当上帝？同时在一个docker中启sshd,httpd服务？ run.sh?
rc.local 呢？

虚拟网卡，虚拟网桥

k8s


architecture day01
//////////////////////////////////////////////////////////
如果以后想下载软件包，可以去centos官网，everything  iso
进去之后有各种iso的下载地址，但是截取地址到centos/7/，如华为云那个地址，然后复制访问，就可以看到下面有个中软件包，ansible在extra中。
http://mirrors.huaweicloud.com/centos/7.5.1804/isos/x86_64/CentOS-7-x86_64-Everything-1804.iso
https://mirrors.huaweicloud.com/centos/7/

这样可以关闭ping
[root@cache ~]# sysctl -a | grep icmp
[root@cache ~]# sysctl -w net.ipv4.icmp_echo_ignore_all=1
net.ipv4.icmp_echo_ignore_all = 1

ansible要多看帮助 ansible-doc 
ansible-doc -l | grep xx 可以找到包含xx字的模块
ansible-doc xxx(模块名)，然后下拉可以看例子

ansible cache -m ping -k 检查的是连通性(ssh)，与ping无关。
[root@ansible ansible]# ls /root/.ansible/cp/
86427c36cb
ansible刚链接上后，会生成这个socket文件，可以直接连，过一段时间才会消失。
在此期间，就算对方停了sshd服务，也能链接。效率！

批量reboot，没有返回值，所以会报红了。

解压.xz文件  xz -d
压缩成.xz    xz -z

ansible配置文件，检查到即停止

["a","b","c"] 数组
"k":"v"  键值对
数组和键值对可以组合起来
!!?

JSON 是一种格式

command模块进去之后，不开起bash，所以bash特性的符号都用不了。
set是bash的内置命令
shell模块会启用bash

'.*(\.114){3}'

ansible t1 -m setup -a 'filter=ansible_distribution' 返回的是个JSON格式

一般来说是从已有的监控软件中，将单位的服务器列表搞到手，而怎样用这个列表在ansible中来进行批量操作？
如果用python读取这个列表，然后输出成一个JSON格式的输出，然后输出到hosts中，然后ansible all -m ping就可以通了。
python中有一个模块print(hson.dumps(hhh))就可以用了。
C语言，当然也能。

所以说，这样逻辑没有跳跃，课上老师讲的跳了。
[web]
web1
web2

[web:vars]
ansible_ssh_user="root"
ansible_ssh_pass="123456"

ansible all -m authorized_key -a "user=root exclusive=true manage_dir=true key='$(< /root/.ssh/id_rsa.pub)'" -k
exclusive: 以前可能部署过，直接干掉，以现在的为主
manage_dir: 秘钥是在/root/.ssh/下面的，但是新装的机器，这个目录是没有的，manage_dir确保，没有这个目录的话就建出来。


architecture day02
//////////////////////////////////////////////////////////
cdn ?
回源 ip ?

好多语言可以解析json
[ ]数组 通过“，”分隔
{}里是键值对（键值对就是对象），键值对之间","分隔
小括号分组

yaml "- " -后面有空格 :也一样

[root@ansible ~]# cat httpd.yml
---
- hosts: db
  remote_user: root
  tasks:
    - yum:
        name: httpd
        state: latest
    - replace:
        path: /etc/httpd/conf/httpd.conf
        regexp: '^(Listen).*'
        replace: '\1 8080'
    - replace:
        path: /etc/httpd/conf/httpd.conf
        regexp: '^#(ServerName.*)m:80'
        replace: '\1m:8080'
    - copy:
        src: /root/index.html
        dest: /var/www/html/
        owner: apache
        group: apache
        mode: 0644
    - service:
        name: httpd
        state: restarted
        enabled: yes
如果不修改ServerName改对让语法不报错，那么/var/log/httpd/access.log记录不上日志!?

[root@ansible ~]# cat user.yml 
---
- hosts: cache
  remote_user: root
  vars:
    u1: 
      uname: "nb"
      ugroup: "mail"
  tasks: 
    - user: 
        name: "{{u1.uname}}"
        group: "{{u1.ugroup}}"
    - shell: echo 123 | passwd --stdin "{{u1.uname}}"
用JSON格式的变量作为参数：
[root@ansible ~]# ansible-playbook user.yml -e '{"u1":{"uname":"haha2","ugroup":"mail"}}'

也可以用文件做为参数，文件里是yaml格式
[root@ansible ~]# cat user.vars 
u1:
  uname: "oo"
  ugroup: "mail"
[root@ansible ~]# ansible-playbook user.yml -e '@user.vars'

这个文件下有用户设置信息，最下面的是密码加密方法（小写）
[root@ansible ~]# cat /etc/login.defs
# Use SHA512 to encrypt password.
ENCRYPT_METHOD SHA512 

yaml文件中可以调用jinjia2格式，但要用{{}}括起来。
（ppt）

ssh -l cache nb 远程

ansible-playbook 出错的话，会有报错，而script模块脚本过去之后，执行不报错。


playbook在执行到某一行，返回值不为0的时候，就报错并终止了。比如添加一个已有的账号：
useradd haha haha存在则报错终止。
但在后面价一个echo
useradd haha; echo
那么返回值就是0了，那playbook就不报错了。

不过还是用ignore_errors:true 好
---
- hosts: web1
  remote_user: root
  vars:
    u1: nb
  tasks:
    - shell: useradd "{{u1}}"
      ignore_errors: true
    - shell: echo 123 | passwd --stdin "{{u1}}"
既报错了，又往下执行了。
缩进到那个下面，就是谁的

handlers 的注释，与引用的必须一样
直到tasks全执行完，才会调用handlers

      notify:
        - restart httpd
- 代表数组，可以罗列很多

---
- hosts: web
  remote_user: root
  vars:
    theport: 8080
  tasks:
    - yum:
        name: httpd
        state: latest
    - replace:
        path: /etc/httpd/conf/httpd.conf
        regexp: '^(Listen).*'
        replace: '\1 {{theport}}'
      notify:
        - restart httpd
      tags: changeport
    - replace:
        path: /etc/httpd/conf/httpd.conf
        regexp: '^(ServerName).*'
        replace: '\1 localhost'
      notify:
        - restart httpd
    - copy:
        src: /root/index.html
        dest: /var/www/html/
        owner: apache
        group: apache
        mode: 0644
  handlers:
    - name: restart httpd
      service:
        name: httpd
        state: restarted
        enabled: yes
tags放到nodify上面，handlers也能执行!?


playbook 的循环，判断，分支
when:

result.stdout|float

result是个json字符串

测试运行可能会错。

http://docs.jinkan.org/docs/jinja2/templates.html#builtin-filters

---
- hosts: web1
  remote_user: root
  vars:
    u1: nb2
  tasks:
    - user:
        name: "{{u1}}"
        password: "{{'123456'|password_hash('sha512')}}"
这个playbook是调用了一个jinja2模板，调用hash给123456加密，加密的方法可以在/etc/login.defs看到是sha512算法。管道把123456给password_hash加密，然后存到/etc/shadow中。不然存的是123456,这样救没法登陆。但是登录的时候怎么看老师是用的一大长串的加密后的密码？

copy的0644是权限？


architecture day03
//////////////////////////////////////////////////////////
ELK是一套解决方案，与LNMP平级
L K 适合放到docker中
E：非关系型

安装elk步骤：
1.准备es1机器，安装elasticsearch:
    1.安装java-1.8.0-openjdk
    2.制作yum源，yum安装elasticsearch
    3.配置文件/etc/elasticsearch/elasticsearch.yml
      network.host: 0.0.0.0
      启动,9300会先启，然后9200
    4.RESTful API接口---Web接口，直接浏览器访问
      curl 192.168.1.111:9200 成功
2.集群：es1-es5 (ansible更好)
    1./etc/hosts 主机名ip全对应, yum 群体装包
    2.每一个机器的配置文件：
      cluster.name: c1 (相同)
      node.name: esx  (本机)
      network.host: 0.0.0.0
      discvery.zen.ping.unicast.hosts: ["es1","es3",..]多写两台,万一坏了。
    3.全部重启服务，访问任意机器
      192.168.1.111:9200/_cluster/health?pretty
      集群好了，对elasticsearch集群增删改查要用http协议
    4.装各种插件 head kopf bigdesk
      /usr/share/elasticsearch/bin/plugin

    ----day03 下午95分钟


http协议：
请求行: GET / HTTP/1.1 \r\n
curl还支持ftp
curl -i xxxxxxxx 请求头
[root@es1 ~]# curl -XPOST 118.144.89.240/info.php
curl -X xxxxxxxx 是发送操作
curl xxxxxxxx -d xxx 上传文件或者字符串(用户密码认真)?
curl xxxxxxxx -A xxx 改agent(浏览器)

配置elasticsearch集群的时候，配置文件中node.name: es1   es2  ...   不同的主机不同，那么怎么ansible-playbook操作？
可以用template模块，因为
ansible es1 -m setup -a 'filter="ansible_hostname"'
可以看到有个变量储存了主机名。所以在当前目录下复制过来一个elasticsearch.yml，里面的node.name: "{{ansible_hostname}}"，这样用template模块将文件复制到各个主机里去，变量就直接替换了。
---
- hosts: es
  remote_user: root
  tasks:
    - template:
        src: elasticsearch.yml
        dest: /etc/elasticsearch/elasticsearch.yml
        owner: root
        group: elasticsearch
        mode: 0750

[root@es1 ~]# curl -XPOST http://192.168.1.111:9200/tedu/nsd1807/3/_update -d '
{
  "doc":{"年龄":"18"}
}
'
tedu是索引（库？）nsd1807是类型

有的时候，配置了5台es的集群，为什么只显示4台？
因为discovery.zen.ping.unicast.hosys:["","",""]只写了3个，如果第一个启动的机器没有在这里面，那么后启动的在这里的那3个，就没法发现第一个启动的机器了。

architecture day04
//////////////////////////////////////////////////////////

input 负责收集数据
filter 负责处理
output 数据发送到哪里去

logstash-output-file 把输出结果写到文件
logstash-input-stdin 标准输入(键盘鼠标)
logstash-output-stdout 标准输出(显示到屏幕)

如cat，这个命令就像ppt上的例子
cat 回车，然后输入什么，就输出什么
这就是标准输入，然后标准输出


---->
[root@logstash logstash]# /etc/logstash/logstash.conf
input {
  file {
    path => ["/tmp/a.log","/var/tmp/b.log"]
  }
}
filter{}
output{
  stdout{ codec => "rubydebug" }
}
[root@logstash logstash]# touch /tmp/a.log
[root@logstash logstash]# touch /var/tmp/b.log
[root@logstash logstash]# logstash -f logstash.conf
...
这样在另一个终端，echo A_${RANDOM} >> /tmp/a.log 就可以看到变化，可以监控文件了。

要怎么看文档：
https://github.com/logstash-plugins
然后随便点一个
然后往下拉到Documentation，点central location
等列表左边+出现，然后点input plugins --> file
拉倒下面有个例子
input {
  file {
    id => "my_plugin_id"
  }
}
拉到上面：
File Input Configuration Options
看到下面的列表，是可以往上面的例子添加的值
最左列是id，中间是my_plugin_id的类型，最右端是是否必须。
只有一个是必须的,path

logstash会按照一个指针文件来查找处理文件。
[root@logstash logstash]# cat /root/.sincedb_e9a1772295a869da80134b5c4e75816e
423 0 64769 8
3145796 0 64769 16
这个是指针文件，记录了上次关闭的时候，读到了哪里。下次会继续上面读。

指针文件默认在用户的家目录，但是一般最好把指针文件放到公共目录，所以指定了sincedb_path => "/var/lib/logstash/since.db"指针文件的位置。

一个新的指针文件，默认是从end开始读取，所以要指定成beginning：start_position => beginning

可以打标签：type => "apache_log"

所以：
input {
  file {
    path => "/tmp/a.log"
    sincedb_path => "/var/lib/logstash/since.db"
    start_position => beginning
    type => "apache_log"
  }
  file {
    path => "/var/tmp/b.log"
    sincedb_path => "/var/lib/logstash/since.db"
    start_position => beginning
    type => "nginx_log"
  }
}
filter{}
output{
  stdout{ codec => "rubydebug" }
}

这些都可以在官方文档中查到。

tcp要区分服务端 mode=>"server" 还是客户端"client"，不然怎么知道监听的地址是啥
udp就没这区分。

系统日志的配置文件
[root@httpd ~]# vim /etc/rsyslog.conf
local0.=notice    @192.168.1.118:514
authpriv.*    @@192.168.1.118:514
[root@httpd ~]# systemctl restart rsyslog.service 
[root@httpd ~]# logger -p local0.notice -t nsd1807 'Hello World!'
重启，或者写日志，logstash哪里都会有记录。

最后的'\""'之间不能有空隔!!
match => { "message" => "(?<client_ip>[0-9.]+).*\[(?<time>.*) .*\] \"(?<method>[A-Z]+) \/ (?<proto>[A-Z]+)\/(?<version>[0-9.]+)\" [0-9]+ [0-9]+ \"\-\" \"(?<browser>[a-z]+\/.*)\"" }  自己写的

[root@httpd ~]# grep -Pv "^\s*($|#)" /etc/filebeat/filebeat.yml

[root@logstash ~]# vim /opt/logstash/vendor/bundle/jruby/1.9/gems/logstash-patterns-core-2.0.5/patterns/grok-patterns


architecture day05
//////////////////////////////////////////////////////////

浩方 的技术是 vpn

安装java-1.8.0-openjdk-devel(自动解决依赖，安装了openjkd)

[root@hadoop-nn01 hadoop]# jps
1037 Jps
[root@hadoop-nn01 hadoop]# java version

如何看java的home呢？
[root@hadoop-nn01 hadoop]# rpm -ql java-1.8.0-openjdk
发现下面的四行是图片，倒数第5行是桌面图标，上面几行再/jar之前都相同，所以home是：/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.131-11.b12.el7.x86_64/jre
而hadoop的配置文件在：/usr/local/hadoop/etc/hadoop 下面

拷贝秘钥，hadoop-nn01也得给自己拷，因为这里seconderynamenode跟namenode放到了一起

登陆hadoop.apache.org/docs/ 看文档怎么配置hadoop。
点开对应版本，左边栏最下面有configureation.

在hadoop-nn01配置好的后，直接将/usr/local/hadoop同步到node1-3。-a(归档模式，保留原文件的权限归属)，-S(对稀疏文件特殊处理)，-H(保留硬连接)，--delete(删除dest中src没有的文件)，-e(使用协议)。
[root@nn01 hadoop]# for i in 22 23 24 ; do rsync -aSH --delete /usr/local/hadoop/ 
\   192.168.1.$i:/usr/local/hadoop/  -e 'ssh' & done
--->dest端也要安装rsync

1.安装单机hadoop    主机名hadoop-nn01
    1.安装java-1.8.0-openjdk-devel
    2.解压hadoop的tar包，移动为/usr/local/hadoop
    3.修改etc/hadoop/hadoop-env.sh中的JAVA_HOME，HADOOP_CONF_DIR。
2.安装hadoop集群
    1.hadoop-nn01,node1,node2,node3主机，/etc/hosts ip全对应。
      hadoop-nno1: NameNode, SeconderyNameNode.
      node1-node3: DataNode.
    2.hadoop-nn01 拷秘钥给4台。
    3.配置hadoop-nn01中/usr/local/hadoop/etc/hadoop/下面：hadoop-env.sh, core-site.xml, hdfs-site.xml, slaves
    4.直接将/us/local/hadoop同步给node1-3
    5.hdfs namenode -format ---> start-dfs.sh ---> ssh node1 jps, hdfs dfsadmin -report


architecture day06
//////////////////////////////////////////////////////////
NodeManager占用cpu，内存多
DataNode占用磁盘io，网络io多
NameNode占cpu，内存多
ResourceManager是分割数据然后给NameNode计算，所以不是很占cpu，所以可以与NameNode放到一起。
所以上面两个可以放到一起
但是两个占用相同资源的不能放到一起。

如果没有正常关机，那么4台机器的/var/hadoop下的数据可能就不一致了，所以stop，删除/var/hadoop下的数据，然后重新格式化启动

vimdiff xx xx

mapreduce.framework.name 让其不使用本机资源，而使用集群的管理框架

[root@hadoop-nn01 hadoop]# for i in node{1..3}; do rsync -aSH --delete /usr/local/hadoop/etc ${i}:/usr/local/hadoop/ -e 'ssh' & done

windows 装vim

hadoop jar ./share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar wordcount /input /output
上面的/input的完整路径是: hdfs://hadoop-nn01:9000/
回想前一天的wordcount算法，命令跟上面基本相同，那么怎么区分/是本地的还是hdfs://xxxx:9000/的？
主要看core-site.xml里的fs.defaultFS写的是啥
如果是file:/// 那就是本地
如果是hdfs://xxxxx  那就是hdfs的。

nfs + rsync + inotify + keepalive  100G以下的可以，太大了会有进程方面的问题

DRDB + heartbeat  同步数据实现高可用 300G以下

hdfs + nfs(gateway) 可以好几个t

要点：
1.nfs网关只支持v3版本
2.随机数据(如迅雷下载有的不是从头下载，而是分好几个点一起下载)需要缓存目录
3.错误日志： logs/xxx.log  logs/xxx.out
4.nfs网关是hadoop集群的一个客户端，所以/etc/hosts
5.hadoop.proxyuser.nfsuser(代理用户).groups .hosts 是授权哪些主机可以访问。
6.清空nfsgw的hadoop/logs目录内容不影响hadoop集群
7.nfsgw的系统的原nfs-utils要卸了，用自己做的不用。
8./etc/exports 是nfs的配置文件，nfs.exports.allowed.hosts使用java语言来配置这个文件。
9.nfs.dump.dir设置转储文件。
10.要让nfsuser代理用户对hadoop/logs目录有读写权限。
11.先启动portmap(root),再启动nfs3(su 到代理用户),启动顺序变了就重启。
12.再启一台机器,挂载。

hadoop-daemon.sh stop namenode  这样!!


architecture day07
//////////////////////////////////////////////////////////
事务?

zookeeper如果4台机器1个obersver,那么3台至少启2台。

项目2
//////////////////////////////////////////////////////////
从华为云上下载的私钥是xxx.pem，将其复制到~/.ssh/下面后，要mv成id_rsa，然后改权限。

制作华为云后端盘：
1.yum:
华为云上搜索yum，按照第一个curl上yum源。
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.myhuaweicloud.com/repo/CentOS-Base-7.repo
yum clean all 一定要做
yum makecache

2.卸载
netstat -nutpl
yum -y remove postfix

3.时间同步：
ntpd (看/etc/ntp.conf中的时间服务器的地址)
server ntp.myhuaweicloud.com iburst
贴到/etc/chrony.conf  注释掉#server 3(1-3).centos.pool.ntp.org iburst等
chronyc sources -v

4.
/etc/ssh/sshd_conf 打开port 22 listen 0.0.0.0 就可以只监听ipv4
/etc/sysconfig/chronyd  中 ""  加上-4，就是只监听ipv4了。

5.这个要不又要做呢?华为云上的与真实的有没有什么区别?
systemctl stop NetworkManager   (disable)
删了ifcfg-eth1-4
ifdown eth0                很重要
systemctl start network



华为云--支持与服务--后面的放大镜 可以搜索一些方法。


lvs net模式：网关需要指向lvs，但是云主机的网关是默认指定的>。
lvs dr模式：web主机是没法上网的，那么包怎么转发出去？

lvs full-net模式：就用这个，免费买

[root@room9pc01 myfiles]# for i in {1..60}; do curl -s 119.3.7.240; done | sort | uniq -c

云主机做lvs dr 负载均衡要点：
浮动公网ip与申请不要钱的虚拟ip绑定，再绑到lvs-web1-web2上。


locat -i xxx 可以找到包含xxx字的文件。
mv xxx /dev/shm 相当于删除..
[root@mycat1 mycat]# find . -type d -exec chmod 755 {} \;
[root@mycat1 mycat]# find . -type f -exec chmod 644 {} \;
find后接命令。

ss -ant   a--all   n--port number   t---tcp
the_one ---> mysql -urw -prw -hhaproxy1 ---> system bash ---> ssh haproxy1 ---> ss -ant

tcp 3 connect   4 disconnect  10 status
ESTAB is the 3 connect status
TiME-WAIT is 4 disconnect status

mysql> show databases;
+----------+
| DATABASE |
+----------+
| mycatdb  |
+----------+
1 row in set (0.00 sec)

mysql> system bash
[root@the-one ~]# ssh haproxy1
[root@haproxy1 ~]# ss -ant
State      Recv-Q Send-Q  Local Address:Port                 Peer Address:Port              
LISTEN     0      128                 *:3306                            *:*                  
LISTEN     0      128                 *:22                              *:*                  
LISTEN     0      100         127.0.0.1:25                              *:*                  
ESTAB      0      0       192.168.1.129:39738               192.168.1.211:8066               
ESTAB      0      0       192.168.1.101:3306                 119.3.84.227:36270              
ESTAB      0      0       192.168.1.129:22                    192.168.1.2:50812              
LISTEN     0      100               ::1:25                             :::*                  
CLOSE-WAIT 1      0        ::ffff:192.168.1.129:39126                ::ffff:100.125.32.34:80                 
[root@haproxy1 ~]# ss -ant
State      Recv-Q Send-Q  Local Address:Port                 Peer Address:Port              
LISTEN     0      128                 *:3306                            *:*                  
LISTEN     0      128                 *:22                              *:*                  
LISTEN     0      100         127.0.0.1:25                              *:*                  
ESTAB      0      0       192.168.1.129:22                    192.168.1.2:50812              
LISTEN     0      100               ::1:25                             :::*                  
CLOSE-WAIT 1      0        ::ffff:192.168.1.129:39126                ::ffff:100.125.32.34:80 

[root@haproxy1 ~]# exit
登出
Connection to haproxy1 closed.
[root@the-one ~]# exit
exit
mysql> show databases;
ERROR 2013 (HY000): Lost connection to MySQL server during query
mysql> show databases;
ERROR 2006 (HY000): MySQL server has gone away
No connection. Trying to reconnect...
Connection id:    4
Current database: *** NONE ***

+----------+
| DATABASE |
+----------+
| mycatdb  |
+----------+
1 row in set (0.01 sec)

mysql> 

again   diffirent  dest  !!

[root@haproxy1 ~]# watch -n 1 'ss -ant'
try it many times !!


keepalived:
1.base conf
2.relate keepalived with haproxy
  write a xx.sh ckeck the haproxy status
  (add:)
    track_script {
       chk_haproxy weight=0    # +2 if process is present
    }
  when chk_haproxy failed then set the weight to 0, which means do not keep the ip (weight=0, but keepalived will still runing).
  (add: before vrrp_instance)
    vrrp_script chk_haproxy {
      script "killall -0 haproxy"     # cheaper than pidof       #here inside "" can be the path of xx.sh, or just the script like above. If the $? of the xx.sh if 0 the check is ok or is fail. If wanna use a xx.sh, we can check the pid, cause every process has a pid file, if the file exist, then return 0, or return 1.:"
      # #!/bin/bash
      # PID=$(< /var/run/haproxy.pid)
      # if [ -d /proc/${PID:-0000} ];then
      #     exit 0
      # else
      #     exit 1
      # fi "
      # In fact, it should not be such troublsome,  "kill"  can send a signal to pid of a progress. the signals content 64 system signals and 4 not real signals. progress recive the signal then deal with it. "[root@haproxy1 ~]# kill -l"  look look. If only send 0 to a pid of a progress, if it exist, then it just recive it and return 0, and do nothing.like:
      # [root@haproxy1 ~]# cat /var/run/haproxy.pid 
      # 1272
      # [root@haproxy1 ~]# kill -0 1272
      # [root@haproxy1 ~]# echo $?
      # 0
      # [root@haproxy1 ~]# kill -0 1273
      # -bash: kill: (1273) - 没有那个进程
      # [root@haproxy1 ~]# echo $?
      # 1
      # if the pid was not known , we can killall -0 haproxy 
      interval 2                      # check every 2 seconds
    }


3.double work mode
  1: eth0:1 rub,  eth0;2 no rub
  2: eth0:1 no rub,  eth0:2 rub

both keepalived service should be set as BACKUP, or the master will always rub the virtual_ip

priority 200   ----  nopreempt       no rub
priority 100   ----  ! nopreempt     rub cause of the low priority

4.DNS A record  !!  roundrobin
  then visit one domain name, can visit the two haproxy roundbin

51job 前程无忧
智联招聘
中华英才

github
///////////////////////////////////////////////////////////////////////
1. 先去官网按照说明创建一个repositroy
2. ssh-keygen -t rsa -C 'frnorth@github.com', 然后把id_rsa.pub的内容复制，在github的头像下面的settings里面添加一个ssh公钥，粘贴过去。
3. ssh -T git@github.com 能连接了
4. git clone git@github.com:frnorth/note.git 把repository clone下来，注意ssh的与https的不一样
5. 编辑 ...
6. git add .
   git commit -m 'haha'
   git push origin master

6/1. git pull 因为别人也在更新，所以如果5报错，那么先git pull

git -h
git add -h
不会了就看帮助


[root@mini ~]# vim /etc/vimrc 添加，缩进4
set tabstop=4


jenkins:
https://jenkins.io/  java -jar jenkins.war --httpPort=8080

maven打包:
1. 安装java和maven
---> 注意别忘了装java
2. git clone  注意分支，不同的分支代码不一样
---> 注意哪个分支能打包成功
3. mvn clean package -Dmaven.test.skip
---> 前人在jenkins上写了发布的过程和脚本，那么按照上面的配置
  clean: 清楚当前目录包含的所有的target
  -Dmaven.test.skip 跳过测试
  package命令完成了项目编译、单元测试、打包功能，但没有把打好的可执行jar包（war包或其它形式的包）布署到本地maven仓库和远程maven私服仓库
  install命令完成了项目编译、单元测试、打包功能，同时把打好的可执行jar包（war包或其它形式的包）布署到本地maven仓库，但没有布署到远程maven私服仓库
  deploy命令完成了项目编译、单元测试、打包功能，同时把打好的可执行jar包（war包或其它形式的包）布署到本地maven仓库和远程maven私服仓库


Linux下制作u盘启动盘：
df -h
umount /dev/sdb
mkfs.fat /dev/sdb -I
dd if=ubuntu-16.0.3-desktop-amd64.iso of=/dev/sdb 注意是sdb不是sdb4?


xargs:
---> 将标准输入的内容转化成参数
  echo "--help" | cat
  echo "--help" | xargs cat
---> 加-i, 用{}代替xargs传来的参数, -I来指定替代符号
  find . -type f -name "split*" | xargs -i cp {} .
  find . -type f -name "split*" | xargs -I R cp R .

nohup:
nohup命令：如果你正在运行一个进程，而且你觉得在退出帐户时该进程还不会结束，那么可以使用nohup命令。该命令可以在你退出帐户/关闭终端之后继续运行相应的进程。
  nohup java -jar xx.jar &


2019.1.8 ** nginx(安装在/usr/local/nginx中)升级可以按照anli里的来做，但是make upgrade的时候，如果是在/usr/bin/下建立了一个链接，然后nginx启动的，会报错。而/usr/local/nginx/sbin/nginx这样启动，在升级的时候就不会报错。nginx -V 可以查看加载了那些模块。

2019.1.8 ** 抓包：打开网页-->F12-->network-->点一个。

2019.1.8 ** 引用postgresql文档中的一句话："The notion of storing data in tables is so commonplace today that it might seem inherently obvious, but there are a number of other ways of organizing databases. Files and directories on Unix-like operating systems form an example of a hierarchical database. A more modern development is the object-oriented database."

2019.1.9 ** 将一个监控脚步本写成systemctl，这样比放到/etc/rc.local开机启动更方便管理，可以直接systemctl start stop 等等。

2019.1.9 ** 装上包 ecryptfs, 然后：mount -t ecryptfs /dir1 /dir1 就可给 /dir1 加密 ?

2019.1.10 ** postgresql 安装的源码包比较隐蔽，在官方文档的最下面，Build fron source --> file browser。

2019.1.10 ** postgresql 9.6 中，装包后的默认管理员帐号是postgres, sudo su - postfres, 然后才能 createdb mydb --> psql mydb.

2019.1.10 ** postgresql 9.6 中，插入操作，如果插入字符串，要用单引号''，而不能用双引号""

2019.1.10 ** postgresql 9.6 中，copy操作，文件格式问题，tab分隔，权限问题，postgres用户能读取到的文件。

2019.1.10 ** postgresql 中，官方文档中的9.6文档2.1节，$ cd ..../src/tutorial $ make 这是在源码包中，要安装了源码包才能在tutorial中make, 但是安装完源码包后怎么启动...?

2019.1.11 ** docker有很多版本，有的版本太低很多操作做不了，安装docker-ce可以用官方文档的步骤，在bookmarks.html中有记载。

2019.1.15 ** postgresql 9.6 mydb=\# \d (显示出有那些表), mydb=\# \d cities (看表的结构)

2019.1.16 ** kubenetes权威指南中的坑: (1)kubectl describe rc mysql {No API token found for service account "default"...} ---> []\# openssl genrsa -out /etc/kubernetes/serviceaccount.key 2048 ---> []\# vim /etc/kubernetes/apiserver (KUBE_API_ARGS="--service_account_key_file=/etc/kubernetes/serviceaccount.key") ---> []\# vim /etc/kubernetes/controller-manager (KUBE_CONTROLLER_MANAGER_ARGS="--service_account_private_key_file=/etc/kubernetes/serviceaccount.key") ---> 重启k8s ---> delete 然后create

2019.1.16 ** kubenetes权威指南中的坑: (2) kubectl describe pods mysql-9nmx0 {details: (open /etc/docker/certs.d/registry.access.redhat.com/redhat-ca.crt: no such file or directory)} ---> []\# wget http://mirror.centos.org/centos/7/os/x86_64/Packages/python-rhsm-certificates-1.19.10-1.el7_4.x86_64.rpm ---> []\# root rpm2cpio python-rhsm-certificates-1.19.10-1.el7_4.x86_64.rpm | cpio -iv --to-stdout ./etc/rhsm/ca/redhat-uep.pem | tee /etc/rhsm/ca/redhat-uep.pem ---> delete 然后 create

2019.1.17 ** ubuntu upan安装系统: 

2019.1.17 ** gitlab添加帐号用户: 扳手图标, 添加用户, 选择组, 将用户添加到组。

2019.1.17 ** :51,105s, \{8\},    ,g  匹配，每8个空格变成4个

2019.1.17 ** landmind ftp ftp:192.168.1.7  lanjingftp cdlanjing

2019.1.17 ** jumpserver https://github.com/jumpserver/jumpserver

2019.1.17 ** redis https://github.com/antirez/redis

2019.1.17 ** maven 打包的时候因为需要很多依赖包，所以要用本地的repositroy ---> .m2/repository/

2019.1.17 ** 让nginx对外可见目录结构: 在location / 中添加i: autoindex on; autoindex_exact_size off; autoindex_localtime on; alias 后面的目录最后要有"/"...

2019.1.17 ** 
```
 #include<stdio.h>
 int main() {
	 printf("Hello World!");
     return 0;
 }
```

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







