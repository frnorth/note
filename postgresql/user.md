select * from pg_roles;    
1.创建一个用户名为readonly密码为123456的用户  
  CREATE USER readonly WITH ENCRYPTED PASSWORD '123456';  
  
2.更新用户默认为只读事务  
  alter user readonly set default_transaction_read_only=on;  
  
3.把所有库的public的USAGE权限给到readonly  
  GRANT USAGE ON SCHEMA public to readonly;        
  
4.授予select权限(要进入到具体数据库操作在哪个db环境下执行就授予那个db的权限)  
   grant select on all tables in schema public to readonly;  
  
作者：山猫233  
链接：https://www.jianshu.com/p/77a626e4225f  
来源：简书  
简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。  
