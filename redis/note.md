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

3. 
```
redis-cli MONITOR > /tmp/redis_monitor.log
tailf /tmp/redis_monitor.log
```

4. 连接redis集群, 在最后加上 -c 即可  

5. 全清缓存
```
dbsize
flushall
```
