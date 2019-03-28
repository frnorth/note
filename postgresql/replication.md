# 照书做还是有一些注意事项
1. listen_addresses 等系统参数, 要select pg_reload_conf()之后, 还是要重启数据库才能生效.  
2. archive_command 改完后, select pg_reload_conf()之后好像不用重启就能生效.  
3. select * from pg_user;  

# pg_basebackup
1. 改配置:
```
psql -h 192.168.1.101 -p 5431 -U postgres -W
  alter system set listen_addresses = '*';
  alter system set wal_level = hot_standby;
  alter system set archive_mode = on;
  alter system set max_wal_senders = 5;
  alter system set wal_keep_segments = 10;
  alter system set archive_command = 'cp %p ../archive/%f';
  select pg_reload_conf();
  create role pgrepuser replication login password '123456'
echo 'host replication pgrepuser all md5' > pg_hba.conf;
```
2. 备份:
```
pg_basebackup -D archive/backup1/ -h 127.0.0.1 -p 5432 -c fast -X stream -R -U pgrepuser
```
3. 恢复:
```
pg_xlogdump -b(-f) 000000010000000000000004 看日志
```
