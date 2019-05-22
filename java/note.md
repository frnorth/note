tar -zxvf jdk-8u212-linux-x64.tar.gz 
mv jdk1.8.0_212 /usr/local/java
vim /etc/profile
```
JAVA_HOME=/usr/local/java
JRE_HOME=/usr/local/java/jre
CLASS_PATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib
PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
export JAVA_HOME JRE_HOME CLASS_PATH PATH
```
java -version
