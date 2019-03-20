FROM centos:latest
#curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
RUN yum makecache && \
    yum -y install bind* && \
    echo "#!/bin/sh" >> /enterpoint.sh && \
    echo "/usr/sbin/named" >> /enterpoint.sh && \
    echo "while 2>1:; do sleep 10; done" >> /enterpoint.sh && \
    chmod 777 /enterpoint.sh
	
ENTRYPOINT ["/bin/sh","-c","/enterpoint.sh"]
#ENTRYPOINT ["/bin/sh","-c","/usr/sbin/named"]
