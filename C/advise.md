1. C/learn/chapter4/strindex.c C/learn/chapter5/exer5/exer.c
```C
int strindex(char s[], char t[])
{
    int i, j, k;

    for (i = 0; s[i] != '\0'; i++) {
        /* 这里隐藏了一个逻辑, 当i比较靠近边界的时候, t长度已经比剩余的s长了, 
         * 而, 循环中没有做额外的判断, 因为s[j] == t[k] 足够了, 
         * 因为, s[j]到了边界是'\0', 自然会 != 未到边界的t[k], 使循环结束*/
        /* 这样是不是更简洁, 而且逻辑完备? 原版, 为了将t[]为空字符串的情况, 归类为不包含, 而多进行了一次k > 0判断. 然而, 如果想如下这样, t[]为空的情况会被s[j++] == t[k++]排除, 而s[]为空的情况会被开头的s[i] != 0排除.
        for (j = i, k = 0; s[j++] == t[k++];)
            if (t[k] == '\0')
                return i;
        */
        for (j = i, k = 0; t[k] != '\0' && s[j] == t[k]; j++, k++)
            ;
        if (k > 0 && t[k] == '\0')
            return i;
    }
    return -1;
}
```
