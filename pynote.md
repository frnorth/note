# 操作
1) pip --help ---> pip config --help ---> pip config list
2) If this fails your Python may not be configured for Tk 如果出现了这样的报错, 那因该是没有为python正确的配置环境, 安装了python3-tk是在安装python3之后进行的, 所以重新安装python3.6.5
```
sudo apt install python3-tk tk-dev (Ubuntu)
yum install python3-tk tk-devel (Centos)
```

# 数据结构
[split_merge_sort](#split_merge_sort.py)  
[arraybag.pyANDlinkbag.py](#arraybag.pyANDlinkbag.py)  
[linkstack](#linkstack.py)  
[grid](#grid.py)  
  
1) 隐藏数据结构, 通用结构不直接看到数据结构, 有些方法直接访问底层数据, 而有些则可以避免直接访问底层数据的方法中, 这样就增加了通用性。  
2) pyunit 单元测试工具?  
3) 
```
b1=ArrayBag()
for i in range(6) b1.add(i)
b1Iter=iter(b1)    #显示调用了迭代器
print(b1Iter)    #是一串地址
value1=next(b1Iter)    #value1是1, int型
value2=next(b1Iter)    #value2是2, int型
print(b1Iter)    #还是那个地址
```
next不会改变b1Iter的地址, 但是用一次, 往下走一次。注意返回的是迭代器做指的数据, 类型也是这个数据的类型  
那么怎样定位b1Iter到b1的第一个数字(元素)的位置呢?
4) pip install xxx 后, pip list 可以看那些包安装了, pip show xxx 可以看xxx的详细信息, 包括安装的位置。
  
## <span id="split_merge_sort">split\_merge\_sort.py<span>  
1) 分割的时候，(left, middle) (middle+1, right), 不要(left, middle-1)  (middle, right), 合并的时候，第一个判断要：if left>middle 不要 left>middle-1 (left>=middle?), 不然的话，最底层两个数字分不开

## <span id="arraybag.pyANDlinkbag.py">arraybag.pANDlinkbag.py<span>  
1) 分割的时候，(left, middle) (middle+1, right), 不要(left, middle-1)  (middle, right), 合并的时候，第一个判断要：if left>middle 不要 left>middle-1 (left>=middle?), 不然的话，最底层两个数字分不开
1) if not item in arraybag1:  
2) not ... in 就是遍历了arraybag1, 是由__contain__方法实现的?  
3) for i in self: 而不是 for i in self.\_items: 是因为__iter__方法, 直接__iter__(self), 就可以返回self._item._data  
4) in 即__contain__方法, 是要基于__iter__的?  
5) __str__方法中的map(str,self), map里的str方法也是要使用self的__iter__方法?  
6)  
```
[root@mini mypython]# python3 testbag.py 
...
  Expect {}: Traceback (most recent call last):
    File "testbag.py", line 33, in <module>
      test(LinkBag)
    File "testbag.py", line 17, in test
      print("Expect {}:",b1)
    File "/root/mypython/linkbag.py", line 56, in __str__
      return "{"+",".join(map(str,self))+"}"
    File "/root/mypython/linkbag.py", line 14, in __iter__
      yield prob._data
```
 可以看出, print(b1)自动调用了b1的__str__方法(所以不用print(str(b1))), 而map中的str自动调用了self, 即b1的__iter__方法  
7)  
```
	def clear(self):
		self._size=0
		self=LinkBag()
```
 如上或者: self.\_items=None, 千万不要self.\_item=linkBag(), 不然会出现很重的错误  
8) 如果是扩容或者减容的话, 有重新定义了一个实例变量self._memsize, 而不用DEFAULT_CAPACITY来扩容, 是应为DEFAULT_CAPACITY如果变了, 那么紧接着建立的实例的默认总量就会跟着变化。  

## arraySortedBag
1)
```
  def __init__(self,sourceCollection=None):
      ArrayBag.__init__(self,sourceCollection)
```
 显式调用父类ArrayBag的__init__函数, 而且加上(self,..)! 因为一旦调用了ArrayBag的__init__, __init_(self, s..n)_就会调用self的add函数(ArrayBag中用add来添加sourceCollection), 如果在子类ArraySortedBag的ArrayBag.__init__中不显式的写出(self,..), 那么就会调用父类ArrayBag的add函数, 即普通添加。然而, ArraySortedBag要求__init__的时候要有顺序的添加, 所以要调用自己的add函数(有序添加), 所以要显式的写出self, 以免调用父类的
2) 然而虽然上面说的有理, 但是说的好像可以不加,  但是如果不加self, 就会去调用list的_items, 就报错, 所以self还是必须加的..
3)
```
[root@mini learn]# python3 testbag.py 
The items of lyst is: [2013, 61, 1973, 999, 456, 78, 932, 399, 21, 146, 2000, 1983]
Traceback (most recent call last):
  File "testbag.py", line 37, in <module>
    test(ArraySortedBag)
  File "testbag.py", line 9, in test
    b1=bagType(lyst)
  File "/root/mypython/learn/arraysortedbag.py", line 7, in __init__
    ArrayBag.__init__(sourceCollection)
  File "/root/mypython/learn/arraybag.py", line 9, in __init__
    self._items=Array(ArrayBag.DEFAULT_CAPACITY)
AttributeError: 'list' object has no attribute '_items'
```
 ArrayBag.add(self,item), 其实父类的方法调用, 加上self, 就跟普通方法一样用
4)
```
[root@mini learn]# python3 testbag.py 
The list of items added is: [2013, 61, 1973]
Traceback (most recent call last):
  File "testbag.py", line 36, in <module>
    test(ArraySortedBag)
  File "testbag.py", line 9, in test
    b1=bagType(lyst)
  File "/root/mypython/learn/arraysortedbag.py", line 7, in __init__
    ArrayBag.__init__(self,sourceCollection)
  File "/root/mypython/learn/arraybag.py", line 11, in __init__
    self.add(item)
  File "/root/mypython/learn/arraysortedbag.py", line 29, in add
    for i in range(len(self),targetIndex,-1):
UnboundLocalError: local variable 'targetIndex' referenced before assignment

```
然而还是有点与之前想的不同, ArraySortedBag中__init__中, 到达ArrayBag.__init__, 然后还是要回溯到了arraybag.py中的ArrayBag, 然后找到是要用self.add(item)方法, 然后回到ArraySortedBag中, 调用自己的add方法。  
5)
除了for item in self: 这样, 还可以显示的用迭代器
```
s1=ArraySortedBag()
s1Iter=iter(ArraySortedBag)
```
s1Iter是s1的地址, next(s1Iter)是s1的第一个值。  

## <span id="linkstack">linkstack.py.py<span>  
1.  
```
	def __iter__(self):
		def visitNode(node):
			if not node is None:
				visitNode(node._after)
				tmpList.append(node._data)
		tmpList=list()
		visitNode(self._items)
		return iter(tmpList)
```
那么问题来了, 最后的return iter, iter里有个yield? 那么return一个yield, 会保留yield属性, 挂起来? 而且,递归是个好东西啊。

## <span id="grid">grid.py<span>
grid.py中的__getItem__只有两个参数,self和indexRow,而不是self, indexRow, indexCollum, 应为g1[x]这是grid.py里的__getItem__, g1[x][y], 后面的y是Arrays里的__getItem.
