# mypyhton  
arraybag.py中, 如果没有 __iter__ 方法, 那么下面的 __str__ 方法就不能用了, 因为ArrayBag就不支持迭代了  
  
# yum  
阿里yum源: http://mirrors.aliyun.com ---> https://opsx.alibaba.com/mirror  
  
# jumpserver  
创建用户邮件发送没有成功, 可能是因为内存不够, jumpserver的消息先放到队列中。  
  
# gitlab  
gitlab smtp设置: 官网搜索smtp    
或, 转: https://blog.csdn.net/tmtongming/article/details/73162807    
$ sudo vi /etc/gitlab/gitlab.rb    

external_url ‘http://xxhost.com’  
gitlab_rails[‘smtp_enable’] = true  
gitlab_rails[‘smtp_address’] = “smtp.163.com”  
gitlab_rails[‘smtp_port’] = 25  
gitlab_rails[‘smtp_user_name’] = “xxuser@163.com”  
gitlab_rails[‘smtp_password’] = “xxpassword”  
gitlab_rails[‘smtp_domain’] = “163.com”  
gitlab_rails[‘smtp_authentication’] = :login  
gitlab_rails[‘smtp_enable_starttls_auto’] = true  
gitlab_rails[‘gitlab_email_from’] = “xxuser@163.com”  
user[“git_user_email”] = “xxuser@163.com”  
  
$ sudo gitlab-ctl reconfigure  
查看日志  
$ sudo gitlab-ctl tail  
---------------------   
作者：童明Kevin   
来源：CSDN   
原文：https://blog.csdn.net/tmtongming/article/details/73162807   
版权声明：本文为博主原创文章，转载请附上博文链接！  
