
# C programming language 英文版 第2版

1. 26页, main is a function like any other, it may return a value to its caller, which is in effect the environment in which the program was executed.  
2. characterarrays-1-9-1.c中, 这里, 当到达998的时候会出现几种情况? 和书后面说的, By testing the length and the last character returned, main can determine whether the line was too long, and then cope as it wishes. 怎么对应上???
```
    for (i = 0; i < lim -1 && (c = getchar()) != EOF && c != '\n'; ++i)
        s[i] = c;
    if (c == '\n') {
        s[i] = c;
        ++i;
    }
```
3. Exercise 1-16 ~ 1-19 还有一些坑, 回头看看  
4. 当输入了一串sfsbgsfsdfs, 按ctrl+d, 这个时候只是停止本次输入, 而不是getchar()一个ctrl+d, 所以getputchar.c运行后, 输入sfsdfsdf, ctrl+d, 不换行, 直接输出了输入的!, 好像有点明白, 为什么getchar()要这么设计了, 因为如果是
```
while((c = getchar()) != EOF) {
	putchar()
}
```
这个循环再输入asasafds后紧接着一个ctrl+d, getchar()会保证循环中的putchar()能够执行, 即能够输出asasafds, 而如果直接getchar()一个ctrl+d, 那么这次循环判断也就结束了, 就不会有输出了!  
5. "Expressions connected by && or || are evaluated left to right, and evaluation stops as soon as the truth or falsehood of the result is known."  
6. "A char is just a small integer"  
7. Seems like need not inclouding the <ctype.h> when use tolower() or isdigit() function?  
8. Wanna judge wheather uc*2 > uc, if not, print uc, thus can see the bounder of uc somehow. But the uc*2 will be turned into char or longer implicitly, so explictly chenge uc*2 back to unsigned char is needed.
```
        if (!((unsigned char)(uc*2) >= uc)) {
            printf("uc %d\n", uc);
            uc = 0;
        }
```
The float and double will be inf when so large, so need this:
```
        if (!((double)(d*4) > (double)(d*2)) && countd == 0) {
            printf("%f\n", d);
            countd = 1;
        }
```
9. If the definition of an external variable occurs in the source file before its use in a particular function, then there is no need for an extern declaration in the function. The usual practice is to collect extern declarations of variables and functions in a separate file, historically called header, that is included by #include at the front of each source file.  
10. Why can this program can produce rand number?  
```
/* rand: return pseudo-random integer on 0..32767 */
int rand(void) {
    next = next * 1103515245 + 12345;
    printf("%d\t", next);
    return (unsigned int)(next/65536) % 32768;
}
```
11. 实验-究极1---
```
C/learn/chapter3/exer3/ex3-2.c 编译运行后输入如下, 多次, 观察printf("%s", xx);的结尾的位置变化...
sdfsd\tsdf sdsfsd\nsdfsd
sgdsfsdfs\t\\dsg\\n + 'ctrl+d'
```
12. the functioins in standard library met till now:
```C
<ctype.h>
isspace(char c);
isdigit(char c);
```
13. 这, 是能输出的!  
```C
	if(1 > 2, 2 > 1)
		printf("%d\n", i);
```
14. int 型在边界的变化:
```
-1 * INT_MIN: INT_MIN !!!?
INT_MIN + 1: -2147483647
INT_MIN: -2147483648
INT_MIN - 1: 2147483647
INT_MIN - 2: 2147483646

```
15. Break in switch is very important !!
16. Chapter4 calculater, in while the judgement should not use (--sp > 0), calculate while judgement may confusing.
```
while (sp > 0)
	val[--sp] = 0;
```
17. What is ex4-4 is about?  
18. 如果包含了<math.h>, 那么编译的时候要 cc xx.c xxx.c -lm  
19. 3.1415926 * 2 == 360度
20. isdigit(s[++i] = c = getch()) 顺序是, 先c = getch(), 再s[++i] = c  
21. getop.c前面是s[0]=c=getch()了, 所以, 第一个digit已经有了, 而且, 要++i  
22. 编译好的a.out, 也可以这样用: echo "1 2 +" | ./a.out  可以写测试脚本?  
23. 4.5节, stack.c并不需要包含 "calc.h" 啊!..?  
24. 在file1.c中定义一个external变量, 并加上static: static int i;, 在file2.c中是无法通过extern int i来引用file1.c中的i的. 除非摘掉static.  
25. C/learn/chapter4/printd.c: static i = 0; 这样是初始化(或者不加 = 0), 而递归的时候不会重复初始化. 如果 static i; i = 0;那么每次递归调用都会让 i 重新赋值. 不管怎样, 递归调用都不会重新定义static i;..?  
26. Preprocesser is so interesting
```
C/learn/chapter4/preprocesser/
```

## chapter5
1. C/learn/chapter5/pointer.c, interesting ... int *ip 定义完后, *ip 是 1 ?
```
    int *ip;
    defprint(\*ip);
```
2. C/learn/chapter5/getfloat/getfloat.c
```
    /* if you want to recognize .12 as 0.12 correctly, an additional statement should be attached */
    if (!isdigit(c) && c != EOF && c != '+' && c != '-' && c != '.')

```
3. C programing languange page 99 -- By definition, the value of a variable or expression of type array is the address of element zero of the array. ..?  
数组类型的变量或表达式的值是首元素的地址...
4. C/learn/chapter5/alloc/alloc.c -- alloc 中是 '<=', 因为 'n' 是长度, 而数组索引最后一个是 'n - 1'. 而 afree 中是 '<'.  
5. C programing languange page 102 ..., which is the next free position when the program start. ... the new value of allocp would be at most one beyond the end of allocbuf. ... Zero is the sole exception... -- when: `char *s = 0; s == NULL;` right?  
6. C programing languange page 103 ... <stddef.h> ... ptrdiff_t ...
7. C/learn/chapter5/pointer.c 
```C
    iqc = "abcdefg";
    /* can not modify the contents ...! */
    //*(iqc + 1) = 'h';
```
8. C/learn/chapter5/exer5/exer.c /* distance of address in 4 would result in number 1, for int arrays */

## chapter5
1./learn/chapter6/struct.c -- notice the two /*  */  
