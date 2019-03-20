# 配置文件

1. 服务端要装nagios服务, 客户端要装plugins

2. 安装目录下有个etc:
```
tree
.
├── cgi.cfg
├── htpasswd.users
├── nagios.cfg				主配置文件
├── nrpe.cfg
├── objects					模板
│   ├── commands.cfg
│   ├── contacts.cfg
│   ├── lanjing.cfg
│   ├── localhost.cfg
│   ├── templates.cfg
│   └── timeperiods.cfg
├── resource.cfg
└── servers					要监控的主机和服务
    ├── clients.cfg
    └── services.cfg
```

3. 需求: 监控日志文件, 有出现Error就报警, 连续报警前三次间隔1分钟, errortests(他是admin)和errortests2都收到邮件,  第四次及以后间隔3分钟, 只有errortests(admin)收到邮件,  阴阳两种配置:  
阴:
```
define service{
        use                             lanjing-service
        host_name                       lanjing-ai-03
        service_description             est errors check in /tmp/test.log
        check_command                   check_nrpe!check_log_file -a Error /tmp/test.log
        normal_check_interval           1
        retry_check_interval            1
        notification_interval           1
        max_check_attempts              1
        contact_groups                  errortests, errortests2
}
define serviceescalation {
        host_name                       lanjing-ai-03
        service_description             est errors check in /tmp/test.log
        first_notification              3
        last_notification               0
        notification_interval           3
        contact_groups                  errortests
}
```
阳:
```
define service{
        use                             lanjing-service
        host_name                       lanjing-ai-03
        service_description             est errors check in /tmp/test.log
        check_command                   check_nrpe!check_log_file -a Error /tmp/test.log
        normal_check_interval           1
        retry_check_interval            1
        notification_interval           3
        max_check_attempts              1
        contact_groups                  errortests
}
define serviceescalation {
        host_name                       lanjing-ai-03
        service_description             est errors check in /tmp/test.log
        first_notification              1
        last_notification               3
        notification_interval           1
        contact_groups                  errortests, errortests2
}
```
然而阳配置, 在日志不报错后, errortests2收不到recovery邮件, 所以推荐用阴。  

4. 服务端和客户端都要装nrpe, 客户端配置: etc/nrpe.cfg, 在里面添加command, 可以带$ARGx$, 也可以不带. 
```
command[check_load]=/usr/local/nagios-4.1.1/libexec/check_load -w 15,10,5 -c 30,25,20
command[check_smart]=/usr/local/nagios/libexec/check_smart.pl -d $ARG1$ -i $ARG2$ -b $ARG3$
```
服务端调用: -H ip -c command -a 参数1 参数2 ...
```
./check_nrpe -H 192.168.xxx.xxx -c check_smart -a xxx(ARG1) xxx(ARG2) xxx(ARG3)
```
