apt install rpcbind
apt install nfs-kernel-server
vim /etc/exports 
  /home/share     192.168.1.0/24(rw,sync,root_squash)
  --> 这里, 如果ro, 那么客户端就没法修改文件了  
  --> 最好改成root_squash, 这样客户端root用户在挂在的nfs中操作, 就会被压缩成nfsnobody用户, 就没有权限了  
  --> /share/public 这个目录本身的权限也要考虑, 如果在宿主机设成 user1:user1 755权限, 那么客户端非该uid的用户是没法创建修改删除这个共享的nfs目录下的内容的  
mkdir /home/share (注意属主和属组, 权限755)
service rpcbind start
service nfs-kernel-server start
showmount -e

mount -t nfs 192.168.1.xxx:/home/share /mnt/nfsxxx


