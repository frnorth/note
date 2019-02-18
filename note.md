# 常用命令:
ctrl+shift+c ---> ctrl+shift+v linux复制粘贴  
alt+tab 选择  
vim中: 17+G ---> 跳转到第17行, shift+G ---> 跳转到最后一行  
tab不出来? ---> yum list | grep bash ---> 有completion的,装了, 还不行? yum -y install *-completion   
http://www.gnu.org/software/bash/manual/bashref.html 牛逼了!  
xshell的会话选项卡: 查看--->会话选项卡    
xshell ctrl+鼠标左键, 可以定位光标!  
echo -e 'haha\n' -e 处理特殊字符  
sed -i '/haha/i yeah' xxx.txt 这样在含有haha字的上一行插入yeah  
ctrl+z 放到后台并挂起, bg+%+n 运行后台挂起的, jobs, fg, xxxx &  
unrar x xxx.rar 解压 绝对路径  
yum list installed | grep ^tk 看安装了的包  
vim 1.php --> <?php echo (extension_loaded('openssl')?'SSL loaded':'SSL not loaded')."\n"; ?> --> php 1.php 看openssl有没有加载到php中  

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
passwd u1	(改密码)
vim /etc/sudoers 在root下面填上: u1 ALL=(ALL:ALL) ALL 添加sudo权限
```

# postgresql
1) psql -d mydb -f xxx.sql 通过sql导入数据库

# nagios
1) 安装nagios, 需要一个干净的机器

















-------------------------------------------------------

# lanjing-ecg-cloud docker
[wangjie@PC_wyw:tmp]$ cd lanjing-ecg-cloud-test/  
[wangjie@PC_wyw:lanjing-ecg-cloud-test]$ ll  
总用量 244  
-rw-rw-r--  1 wangjie wangjie    520  1月 23 10:56 README.MD  
-rw-rw-r--  1 wangjie wangjie   1058  1月 23 10:56 requirements.txt  
[wangjie@PC_wyw:lanjing-ecg-cloud-test]$ pyec^C  
[wangjie@PC_wyw:lanjing-ecg-cloud-test]$ pyenv-->python3.6-->pip install -r requirements.tx^C  
grpc需要安装的包:  
  194  pip install grpcio  
  203  pip install protobuf  
  204  pip install grpcio-tools  
还需要的依赖包:  
  225  pip install torch  
  231  pip install sklearn  
  237  pip install biosppy  
  240  pip install --upgrade numpy  
  
lanjing-ecg-cloud 服务:  
1. pip install:  
--requirement.txt  
--grpc:  
    1) grpcio         1.15  
    2) protobuf       没有硬性  
    3) grpcio-tools   1.15  
--torch           0.4.1  
--sklearn         0.19.1  
--biosppy         0.5.1  
2. 安装C库:  
model-service/natives_filters ---> bash install.sh (删掉CMakelist.txt中的DESCRIPATION "...")  
3. bash run_server.sh  
4. cat server.log  
