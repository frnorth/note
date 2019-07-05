转自: http://www.aixiaoxiao.cn/thread-239-1-1.html

开启转发功能
将net.ipv4.ip_forward=0
修改成net.ipv4.ip_forward=1

使其生效：
    sysctl -p
复制代码

运行防火墙命令，如果仅需要tcp则无需运行udp条目
iptables -t nat -A PREROUTING -p tcp --dport [端口号] -j DNAT --to-destination [目标IP]
iptables -t nat -A PREROUTING -p udp --dport [端口号] -j DNAT --to-destination [目标IP]
iptables -t nat -A POSTROUTING -p tcp -d [目标IP] --dport [端口号] -j SNAT --to-source [本地服务器公网IP]
iptables -t nat -A POSTROUTING -p udp -d [目标IP] --dport [端口号] -j SNAT --to-source [本地服务器公网IP]

>>> 例子: 跳板机的公网ip: 1.2.3.4, 线上服务器的其他机器有个192.168.1.222, 1.222上有个服务的端口是8080, 现在将这个8080映射到1.2.3.4的80上:
iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.1.222:8080

保存并重启防火墙生效
    service iptables save
    service iptables restart
复制代码

如果需要修改编辑防火墙规则，在这里编辑防火墙
    vi /etc/sysconfig/iptables
复制代码

==============================
以下举例另外两种可能需要用到的方案：
==============================
多端口转发修改方案：(将本地服务器的50000~65535转发至目标IP为1.1.1.1的50000~65535端口)
-A PREROUTING -p tcp -m tcp --dport 50000:65535 -j DNAT --to-destination 1.1.1.1
-A PREROUTING -p udp -m udp --dport 50000:65535 -j DNAT --to-destination 1.1.1.1
-A POSTROUTING -d 1.1.1.1/32 -p tcp -m tcp --dport 50000:65535 -j SNAT --to-source [本地服务器IP]
-A POSTROUTING -d 1.1.1.1/32 -p udp -m udp --dport 50000:65535 -j SNAT --to-source [本地服务器IP]
============================================================
非同端口号修改方案：（使用本地服务器的60000端口来转发目标IP为1.1.1.1的50000端口）
-A PREROUTING -p tcp -m tcp --dport 60000 -j DNAT --to-destination 1.1.1.1:50000
-A PREROUTING -p udp -m udp --dport 60000 -j DNAT --to-destination 1.1.1.1:50000
-A POSTROUTING -d 1.1.1.1/32 -p tcp -m tcp --dport 50000 -j SNAT --to-source [本地服务器IP]
-A POSTROUTING -d 1.1.1.1/32 -p udp -m udp --dport 50000 -j SNAT --to-source [本地服务器IP]
============================================================

