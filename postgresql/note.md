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
