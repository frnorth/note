# ssh问题
要连接192.168.1.121 但是可能连不上
vim ip-mac
这里要写121的IP和MAC
sudo  arp -f ip-mac
arp -a
arp -a|grep 192.168.1.121

要先ping一下, 然后再arp -a ...  
ping 192.168.1.110  
arp -a 192.168.1.110  
