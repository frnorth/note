# notenote
1. git 可以通过新建分支, 来进行备份
```
github上各种操作, 新建一个分支2019-3-20
本地, git add --> commit --> git push origin master --> git checkout 2019-3-20
```
不过, 如果再切回master, 新建目录文件, 写入, 在没有提交push之前, 在2019-3-20这个分支上, 也能看到这些目录文件和写入.  

2. 本地建分支, 推到github上:
```
git branch test
git push origin test
```

## 回滚
1. 准备:
```
git branch
git checkout test
echo "hahaha" >> README.md
  git add .
  git commit -m 'hahaha'
  git push origin test
sed -i '/hahaha/d' README.md
  git add .
  git commit -m 'del hahaha'
  git push origin test
git log
  commit 2aba85eb88b7b6f69f665e6259bd2e36c2b6d201
  Author: wangjie <763211690@qq.com>
  Date:   Thu Apr 11 11:12:18 2019 +0800
  
      del hahaha
  
  commit 022f98d2993635270b7db00931d5a51d368a3812
  Author: wangjie <763211690@qq.com>
  Date:   Thu Apr 11 11:09:56 2019 +0800
  
      hahaha
```
2. 回滚
```
git branch back-test-hahaha 022f98d2993635270b7db00931d5a51d368a3812
git checkout back-test-hahaha 
git push origin back-test-hahaha 
```

## gitlab  
配置smtp, 新建用户发送邮件:  
官网搜索smtp  
vim /etc/gitlab/gitlab.rb https://github.com/frnorth/note/blob/master/gitlab.rb  
gitlab-ctl reconfigure 重新加载配置  
gitlab-ctl tail 看日志  
貌似要是starttls_auto true 那么gitlab-tls 也得是ture
貌似要加上那个git_user_email


