# pyenv 与 conda
1) 两者再 github 上都有文档  
2) pyenv 中有 pyenv-virtualenv 的链接  
3) git clone 下来 pyenv ---> git clone 下来 pyenv-virtualenv  
4) 要想使用 conda, 先安装 anaconda, 或者 miniconda (包少), github上搜conda ---> 跳到conda官网 ---> getting started with conda ---> 有一句话: before you start you should have already installed Anaconda  
5) pyenv 可以管理 conda, 但是怎么样像pyenv的github上的方法去管理conda的虚拟环境呢?  
6) [root@mini ~]# cat .bash_profile | tail -1 | awk '{print $2,$3}' 哈哈, 牛逼了  
7) pip show 包名  
8) 可以按照ppt上的方式配置pip源, pip --help 可以看各种命令, pip config list看配置  
9) 设置pip源:
```
mkdir ~/.pip
echo "[global]
index-url = http://pypi.douban.com/simple
[install]
trusted-host=pypi.douban.com" > ~/.pip/pip.conf
```
或者:
```
pip install web.py -i http://pypi.douban.com/simple --trusted-host pypi.douban.com
```
10) pyenv install x.x.x 一样需要各种依赖包, 而且需要 curl !:
```
yum -y install curl  !!!
yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel
apt-get install curl
sudo apt-get install gcc make zlib1g-dev libbz2-dev libsqlite3-dev python3-dev libxml2-dev libffi-dev libssl-dev libxslt1-dev
```
