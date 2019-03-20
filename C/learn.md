
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
```
<ctype.h>
isspace(char c);
isdigit(char c);
```

13. 这, 是能输出的!  
```
	if(1 > 2, 2 > 1)
		printf("%d\n", i);
```
