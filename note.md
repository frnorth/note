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

53. ubuntu 测网速
```
sudo apt install speedtest-cli
speedtest-cli
```

54. latex 安装的是Tex live, 安装完后看Testing the installation

55. matlab: 改菜单字体大小
```
>> s = settings;s.matlab.desktop.DisplayScaleFactor
>> s.matlab.desktop.DisplayScaleFactor.PersonalValue = 1.5
```

56. /etc/vim/vimrc 中添加 set mouse=a

57. vimrc中设置了 set mouse=a后, 鼠标选中后无法ctrl+shift+c复制, 应该在选中前按中shift, 再用鼠标选择, 这样就可以了.

58. 删除行首的空格和tab, \s是空格或tab的意思
```
:s,^\s\+,,g
```

59. sudo apt install python3-pip

60. 如果想用 fortran.vim 和fortran_codecomplete.vim 两个插件, 需要在~/.vimrc文件

61. vim中, 所有字母变为大写 不用进入命令模式输入gggUG, 大写转小写ggguG

62. 统计行数 grep | wc -l

63. fortran 中, integer, parameter::n 的意思是n是const

64. openmpi -- LD_LIBRARY_PATH /usr/local/lib/openmpi 的上层目录也要被包含进去
```
LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH; export LD_LIBRARY_PATH
LD_LIBRARY_PATH=/usr/local/lib/openmpi:$LD_LIBRARY_PATH; export LD_LIBRARY_PATH
LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH; export LD_LIBRARY_PATH
LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/openmpi/lib/:$LD_LIBRARY_PATH; export LD_LIBRARY_PATH

```
64. fortran 不区分大小写...

65. 狄拉克函数 可以有e的积分来, 在曾谨言的量子力学书I上的附录中
66. https://github.com/vim-scripts/darkBlue 上面有vim的主题,放到这个目录下: ~/.vim/colors/darkBlue.vim, 然后改 ~/.vimrc:加上 color darkBlue 就可以了

67. putty + Xming 可以实现远程图形，但是Xming得下载旧版本才能安装用，但是还要下载新版本的字体

68. C 语言实时输出: fflush(stdout)

69. fortran 调用 C
```
数组参数会错一位?
fortran 数组从1开始, 对应C的从0开始

```
70. 测试项目总结, 用nvcc编译cuda c, mpif90编译,,, 如果是c++风格 -lstdc++,,, 链接的时候要加上-lcudart -Mcuda -lcufft -lstdc++

71. 正则 替换 调换 941,957s/\(.*\) = \(.*\)/\2 = \1/

72. cuda 学习
```
1.
int deviceCount;
cudaGetDeviceCount(&deviceCount);
int device;
for (device = 0; device < deviceCount; ++device) {
    cudaDeviceProp deviceProp;
    cudaGetDeviceProperties(&deviceProp, device);
    printf("Device %d has compute capability %d.%d.\n",
           device, deviceProp.major, deviceProp.minor);
}

2.
size_t size = 1024 * sizeof(float);
cudaSetDevice(0);            // Set device 0 as current
float* p0;
cudaMalloc(&p0, size);       // Allocate memory on device 0
MyKernel<<<1000, 128>>>(p0); // Launch kernel on device 0
cudaSetDevice(1);            // Set device 1 as current
float* p1;
cudaMalloc(&p1, size);       // Allocate memory on device 1
MyKernel<<<1000, 128>>>(p1); // Launch kernel on device 1

3. cudastream? samples里面有用到

4. cuda 能否用extern?

5. watch -n 1 -d nvidia-smi

6. When compiling in the separate compilation mode (see the nvcc user manual for a description of this mode), __device__, __shared__, __managed__ and __constant__ variables can be defined as external using the extern keyword. nvlink will generate an error when it cannot find a definition for an external variable (unless it is a dynamically allocated __shared__ variable). 

7. cuda __global__递归 在note目录printf中

8. main.c add.cu 编译链接
[wangjie@who-T7910 add]# nvcc -c add.cu 
[wangjie@who-T7910 add]# gcc -o add main.c add.o -lcudart -L/usr/local/cuda/lib64 -lm -lstdc++


``` 

73. cuda升级等
```
cat /proc/version
lsb_release -a
nvcc -v
cat /usr/local/cuda/version.txt

lspci | grep -i nvidia
uname -m && cat /etc/*release

export PATH=/usr/local/cuda-11.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-11.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

```

74. CUDA Dynamic Parallelism 非常重要 cdp CDP Cdp

75. 昆山测试 hip amd hipMalloc hipcc 
```
1. malloc 放到.c文件中, hipMalloc放到.cu中
2. hipcc编译.cu 加上 -amdgpu-target=gfx906 -fno-gpu-rdc,  gcc编译.c,  gcc链接 加上 -lstdc++ -L/opt/rocm/lib -lhip_hcc 
3. 参数列表不能太长?
4. 一定一定要注意看看数组的维度是否正确
```

73. windows 作为网关
```
windows 无线网设置为共享, 这样以太网会被默认设置为192.168.137.1
linux 改ip和网关等就可以了
```

74. ^M  windows 上传到linux的文件结尾会有一个 ^M, vim中用:set ff=unix 即可
