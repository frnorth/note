# jenkins
1. 系统管理 --> 用户管理 可以添加用户  
系统管理 --> 全局安全配置 将新建的用户添加进来, 并选上Read, 这个用户才有全局视图, 然后这个用户登陆才不会出现 "Access Denied 没有Overall/Read权限"  
项目 --> 把用户添加进来, 然后可以赋予权限.  

2. webhook
在jenkins上, 在触发那里, 选中Build when a change is pushed to Gitlab ... 然后点高级里面有个token  
将地址和token分别复制到gitlab: gitlab 选中要发布的分支 `-->` settings `-->` integrations `-->` 添加各种.  
