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
> 2. 资产管理(老版本的在: 授权管理) --> 添加系统用户 (自动生成密钥, jumpserver自动将公钥放到资产的.ssh/authorized_keys中, 私钥自己保存) --> 这个是要被推送到资产上的用户, 在资产的家目录.ssh/authorized_keys中的公钥与跳板机上的一般不同 --> 然后在系统用户上找到新添加的人, 点推送, 推送到 资产上
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


