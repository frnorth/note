1. command always used
```
keys *
keys *yeah*		看所有包含yeah的字段
del yeah-1		删除一个key
exists yeah-2	看一个key有没有
``
2. 
```
echo 'KEYS metadata-10*' | redis-cli -h 192.168.1.151 -p 7379 | awk '{print $1}' > 1.txt`
for i in `cat 1.txt` ; do echo "get $i" | redis-cli -h 192.168.1.151 -p 7379; done
```
