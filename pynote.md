# 数据结构
隐藏数据结构, 通用结构不直接看到数据结构, 有些方法直接访问底层数据, 而有些则可以避免直接访问底层数据的方法中, 这样就增加了通用性。


1.
>>> str(c1)
'2'
>>> c1.__str__()
'2'
这两个是等效的?
c1.__eq__(c2) 与c1==c2 是一样的?

2.
>>> dir(object)
['__class__', '__delattr__', '__doc__', '__format__', '__getattribute__', '__hash__', '__init__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__']
为什么没有看到__eq__方法?

3.
dir(str)  list tuple set dict
help(str)  list tuple set dict

4.
tensorflow
django

5.
split\_merge\_sort.py 中
分割的时候，left~middle middle+1~right
不要 left~middle-1 middle~right
合并的时候，第一个判断要：if left>middle 不要 left>middle-1 (left>=middle?)
不然的话，最底层两个数字分不开

6.
>>> from array import array
>>> a=array("c")
>>> a.append("h")
>>> a.append("s")
>>> a
array('c', 'hs')
>>> a.append("ss")
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: array item must be char
>>> b=array('i')
>>> b.append(3)
>>> b.append(2)
>>> b
array('i', [3, 2])

2019.1.9 ** 链表中，head=Node(data,None)与head=Node(data,next) head.next=None 一样嘛? C一样，python不一样?

2019.1.13 ** print(a1._items[0]),print(a1[0]) 当class中没有定义index的时候，后者会报错。

2019.1.13 ** 退出虚拟环境：deactivate

2019.1.13 ** django 启动时报错，没有sqlite.., 要安装yum install -y sqlite-devel, 启动时候默认只能本机访问，修改settings.py 中的 ALLOWED_HOSTS = ['*'], 并且启动的时候 python manage.py runserver 0.0.0.0:8000

2019.1.15 ** mypython中的yield_next.py有些问题，而根本问题还是什么是yield? 什么是next? 有一个博客写的不错，yield返回之后函数相当于挂起，下次接着返回，return就直接退了


