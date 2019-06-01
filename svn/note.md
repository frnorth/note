## 服务端
apt-get install subversion
svnadmin create /data/svn/project
cd /data/svn/project/
vim conf/svnserve.conf 
  [general]
  anon-access = none
  auth-access = write
  password-db = passwd
  authz-db = authz
vim conf/passwd
  user1 = 123456
  user2 = 123456
  user3 = 123456
vim conf/authz    在最后添加
  user = user1,user2,user3

  [/]
  @user = rw
svnserve -d -r /data/svn/project/
netstat -nutpl | grep 3690
sudo chmod -R 777 db 不然客户端添加不了文件

## 客户端
windows安装客户端 https://tortoisesvn.net/downloads.html
新建文件夹, 进去, 右键 ...  
