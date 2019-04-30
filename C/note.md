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
12. C/learn/chapter5/daymonthyear.c -- If a two-dimensional array was defined below, daytab[0][13] is daytab[1][0], and daytab[0][14] is daytab[1][1] ... interesting ... more, daytab[1] is just the address of first element of the second row, and dereferencing of it like `char it_value = *daytab[1]` is right. After all, two-dimensional array is one-dimensional internally. Although, initialization like `char *d = daytab` would be warned not compatible, which should be `char *d = daytab[0]` ...  more, the boundary issue like month 12 or 13, needed to be considered ...  
```
static char daytab[2][13] = {
    {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
    {0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
};
```
13. C programing languange page 116 -- This shows that the format argument of printf can be an expression too: `printf((argc > 1) ? "%s " : "%s", *++argv);`  
14. C programing languange page 117 -- C/learn/chapter5/find0 -- 书里的原版程序还是有点666啊...  
15. 如果想用标准库的atof, 还是要老老实实的包含到<stdlib.h>  
16. C/learn/chapter5/exer5-10-expr/main.c -- subsequence "++" would be calculate after calling of the function with a parameter processing it: `isnum(\*argv++)`; ... and if wanna execute expr for multiplication: `./expr 2.2 3.3 \*`, notice the '\*', or use the '*' ...  
17. defprintf(atof("1.0E+02")); it is amazing to use atof() like this!  
18. C programing languange page 118 -- ... (An alternate calid form would be **++argv.) ... [] binds tighter than * and ++, ...  
19. C programing languange page 120 -- The generic pointer type void * is used for the pointer arguments. Any pointer can be cast to void * and back again without loss of information, so we can call qsort by casting arguments to void *.  
20. C/learn/chapter5/sortlines2 in C programing languange page 120 -- This program contains casting pointer arguments to void *, which is very interesting ...  
```C
/* Recalling C/learn/chapter4/qsort.c, shows that: one can define another void pointer to the already defined int array[], and calling qsort using the void one, but, defining and decaleration of qsort must use the int v[] and not changing it into void. */
void qsort(int v[], int left, int j);
main()
{
    int array[] = {54, 57, 214, 36, 21, 1, 35, 3, 68, 87, 156, 233, 124};
    void *a = array;
    qsort(a, 1, 11);
}

/* C/learn/chapter5/sortlines2 -- `num ? x : y` require the statement x and y possessing same type, so, arguments of `int numcmp()` need to be const char * just like strcmp dose */
int numcmp(const char *, const char *);
        qsort2((void **)lineptr, 0, nlines - 1, (int (*)(void *, void *))(num ? numcmp : strcmp));
```
