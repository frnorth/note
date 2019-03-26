1. archive_command = 'cp %p /tmp/archive/%f' ! %f前的路径要存在, 要指对. 如果没有对, 那么有个进程, failed on 0000000x000...:
```
ps aux | grep xxx
postgres   115  0.0  0.1 159008  4504 ?        Ss   01:47   0:00 postgres: 9.6/main: archiver process   failed on 000000010000
```
> 而改对后则:
```
ps aux | grep xxx
postgres   115  0.0  0.1 159008  5392 ?        Ss   01:47   0:00 postgres: 9.6/main: archiver process   last was 000000010000000000000005.00000028.backup
```
> 并且在/tmp/archive下面可以看到日志文件.
> 'cp %p ../archive/%f' 如果想成功, /var/lib/postgresql/9.6/ 下面要有archive/  
```
checkpoint; ?
select pg_switch_xlog(); ?
select pg_xlogfile_name(pg_switch_xlog()); ?
```
