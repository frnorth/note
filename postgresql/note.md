1. postgres offical site searching --> libpqxx --> H.1. Client Interfaces  

2. psycopg  

3. 如果刚安装的postgresql不能通过 psql -U postgres -h 127.0.0.1 -W 登陆, 那么要改一下配置文件:
```
find / -name pg_hba.conf
vim /var/lib/pgsql/9.6/data/pg_hba.conf
local   all             all                                     trust
host    all             all             127.0.0.1/32            trust
host    all             all             ::1/128                 trust
```

4. 26.1. Comparison of Different Solutions  

5. 可以去官方文档上去搜索 Streaming Replication  
DRBD, Slony-I, Pgpool-II, Continuent Tungsten, Bucardo, PostgreSQL two-phase commit, WAL archive   

6. 导出与导入.
```
pg_dump -h xxx.xxx.xxx.xxx -p xxxx -U postgres -d xxxxxx -s >/tmp/schema.sql
psql -h xxx.xxx.xxx.xxx -p xxxx -U postgres -d xxxxxx < /tmp/schema.sql
```

7. 纵向显示 ~ mysql  xxxx\G;
```
\x Expanded display is on
select xxxxx;
\x Expanded display is off
```

8. 如果是用docker起的postgresql:
```
copy "user" to '/tmp/userdata.txt'; 那么会复制到docker里的/tmp/userdata.txt!  
copy "user" from '/tmp/userdata.txt';
```

9. deb http://apt.postgresql.org/pub/repos/apt/ YOUR_UBUNTU_VERSION_HERE-pgdg main, 上面一句话, Create the file /etc/apt/sources.list.d/pgdg.list and add a line for the repository. 要自己建一个文件. 安装完启动服务, 可以/etc/init.d/postgresql start 这样启动!  

10. 如果是自己启了一个ubuntu, 装了一个postgresql, 启动后, listen_addresses要设为*, pg_hba.conf最后要加上 host all all all trust, 不然从别的主机上访问不了!
