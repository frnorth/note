apt install rpcbind
apt install nfs-kernel-server
vim /etc/exports 
  /mnt/public     192.168.1.0/24(rw,sync,no_root_squash)
  --> 这里, 如果ro, 那么客户端就没法修改文件了, 
mkdir /mnt/public
chmod 777 /mnt/public
service rpcbind start
service nfs-kernel-server start
showmount -e
