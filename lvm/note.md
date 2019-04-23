# 将很多快硬盘做成逻辑卷
```
  fdisk /dev/sde ... 先将需要的硬盘分好
  pvcreate /dev/sd{c1,d1,e1,f1,g1,h1}
  pvs
  pvdisplay
  vgcreate vg_data /dev/sd{c1,d1,e1,f1,g1,h1}
  pvs
  vgs
  vgdisplay
  vgchange -a y vg_data
  lvcreate -L 10.92T -n lv_data vg_data
  lvcreate -L 10T -n lv_data vg_data
  lsblk
  pvs
  vgs
  lvdisplay /dev/vg_data/lv_data 
  lvremove /dev/vg_data/lv_data 
  vgs
  lvcreate -L 10.9T -n lv_data vg_data
  vgs
  mkfs.ext4 /dev/vg_data/lv_data 
  lsblk
  df -h
  pvs
  vgs
  mount /dev/vg_data/lv_data /data2/
  df -h
```
