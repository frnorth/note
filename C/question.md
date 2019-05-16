# haha
1. Remember do not replace '=' with '==', in the cases you need '='!  
2. 一些没有解决的问题!!
```
ex1-24 ex2-1 2-8.c(getline3) has not been finished yet ... 
C/learn/chapter5/exer5/pointerarrays/lines.c -- interesting ... 
ex-5.9 ... 
The big problem of how to include header files correctly ?? ...   
C/learn/chapter5/dcl -- needed review and, EOFSTATE in getch.c may need change in different situation and, the dcl dirdcl design is elaborate ... self designed expansion code seems clumsy ... this program really need to be review carefully!! ...
```
3. ctrl + d 如果不用EOF判断作为结束的话, 会输出 ÿ !  
4. 好像 MASK 是一个很重要的词  
5. side effect !   
6. evlaute the run-time between binsearch and binsearch2 in else_if_3_3.c, it might be intresting.  
7. linux中的c库, 时已经编译好的, 所以没有.c文件, 都是.o文件? 用的时候直接连接就行了?
8. chapter4 -- calculator -- getop.c -- while (isdigit(s[++i] = c = getch())) 为啥 ++ 放到 i 前面?  
9. 段错误, 一般是怎么引起的?  
10. chapter4 -- calculator -- ./a.out:
```
1 k1(ctrl + d)1	32 	32 
1	491	491
	k: 1

```
这里, 在k: 1后面下一行, 要输入两次 ctrl + d, 才能结束程序, 为什么?  
11. 还是C programing languange chapter4 calculater, getch与ungetch定义在与getop不同的文件中, 那么在getop文件中声明getch不应该加上extern?  
12. Internal static variables?  
13. C programing languange chapter4-9 ..., now that we have discussed the various storage classes.?  
14. C programing languange chapter5 introduction ..., in effect mandating what good programmers already practice and good compilers already enforce. ?
15. C/learn/chapter5/pointer.c 中, 打开那个注释再编译, 会报段错误?  
16. C programing languange page 99 -- By definition, the value of a variable or expression of type array is the address of element zero of the array. ..?
17. C/learn/chapter5/pointer.c array objects can be refered to without bounds??  
18. C programing languange page 103 ...(There is oneexception: the address of the first element past the end of an array can be used in pointer arithmetic.) ...?  
19. C/learn/chapter5/trcpy.c -- 编译好运行, 每次运行s的地址不变, t的地址会变. ..?
20. Why some self-defined functions (white behind main() in the xxx.c) can be used without declareation, some would not then can be used?  
21. C/learn/chapter5/exer5-11-tab/exer5-12-detab.c -- /* is that right to define marco like this? */ ? ... more, This is a so amazing program ...!   
22. C programing languange page 119 -- What would happen not cast lineptr to (void **) when calling the qsort?  
```C
void qsort(void *lineptr[], int left, int right, int (*comp)(void*, void*));
qsort(lineptr, ....)
```
23. <stdlib.h> contains the qsort function, but how to use it?  
24. C programing languange page 128 -- An automatic structure may also be initialized by assignment or ... what is a automatic structure?  
25. C/learn/chapter6/struct2.c -- 102 row `(--tp)->n += YLEN - 5;`, why segment fault when `YLEN - 2`?  
26. C programing languange page 135 ... A sizeof can not be used in a #if line, because the preprocessor does not parse type names. ... what exactly means is this?  
