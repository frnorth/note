# vultr上的云主机可以ping通过, 但是ssh不上
1. 用高质量嵌入式编程里的那个socket, tcp_net_server放到那边的云主机上, 开启server  
tcp_net_client放到国内的, 然后发消息  
server那边的再写个程序, 将标准输出转化成shell命令..  

2. 或者用李欣老师的方法, 那边的ssh到这边, 然后 echo 'Hello World!' > /dev/pts1 这样, 那边的标准输出就会有内容, 然后将标准输出转化成shell命令..  
