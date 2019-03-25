# 照书做还是有一些注意事项
1. listen_addresses 等系统参数, 早 select pg_reload_conf()之后, 还是要重启数据库才能生效.  
2. archive_command 改完后, select pg_reload_conf()之后好像不用重启就能生效.  
3. select * from pg_user;  
