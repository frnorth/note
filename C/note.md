1. goto seems like more important than looks like, as used in linux/kernel/cpu.c  
2. ... a program to print each line of its input that contains a particular "pattern" or string of characters.(This is a special case of the UNIX program "grep"). Seems like "pattern" here has somewhat same meaning with "pattern" in genetic algorithm. 模式, 或许有更深远的意义.  
3. cc main.c f1.c f2.c 这样编译就可以把不同的文件连起来了..
4. We will see later how to define external variables and functions that are visible only within a single source fle.  
5. C/learn/chapter4/calculator -- 对与EOF(ctrl + d), 从标准输入, 像C programing language 第4章, 的 calculater 第一次ctrl + d是结束输入, 第二次, 才会读到EOF. 而如果按照书中原本的程序, ./a.out后, 1 -- ctrl + d * 3次才能结束程序, 所以, 第一次是结束输入, 然而1后面没有字符跟进, 所以getop.c while (isdigit(s[++i] = c = getch()));会huang在那里, 然后ctrl + d, 入了一个EOF, 这样结束了while (isdigit(s[++i] = c = getch()));, 然而到了最后, if (c != EOF) ungetch(c), 所以EOF没有压栈, 就这么消失了, 所以到第3个ctrl + d, 才是在getop.c的前面部分返回一个EOF, 然后程序也结束了.  
6. 如果没有if (c != EOF) ungetch(c), 那么第二个EOF被压栈, 然后, 第三次getop.c会在buf[]中getch()到EOF, 所以第三次ctrl + d不用输入, 就结束了.  
7. in ex-4.10: C/learn/chapter4/calculator/exec-4.10 -- /* seems like, once "while ((type = getop(line, s)) != EOF)" is done, statement  below "goon" label would be executed, by default. Example: ./a.out -- 1 -- 2 -- ctrl + d -- ctrl + d, then while done(case '\0' was not executed), and "getop over" printed */  getop.c 很吊, 而且依然可以改进.  
8. putchar() 是可以输出的, 不是只能输出getchar到的.
9. C programing languange page 99 -- By definition, the value of a variable or expression of type array is the address of element zero of the array. -- When an array name is passed to a function, what is passed is the location of the initial element. Within the called function, this argument is a local variable, and so an array name parameter is a pointer, that is, a variable containing an address. 所以说, 函数调用传递的还是量的值. 指针传递的其实是还是地址 ... !?  
9. C/learn/chapter5/strcpycmp.c -- strcmp 太吊了...
10. C programing languange page 106 -- .. are the standard idioms for pushing and popping a stack; see Section 4.3. ...
```
*p++ = val; /* push val onto stack */
val = *--p; /* pop top of stck into val */
```
11. Statments like: `*p = "Hello World";` `*p = malloc(xxx); *p++ = 'H';`, p would be alloced in differet places in computer.
