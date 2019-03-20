1.
```
./mysga .
```
这样好像不行，不能传“.”进来？  
```
./mysga $(pwd)/
```
这样不错  

2. 遗传算法中，如果variable[i][1]与variable[i][2]，之间有限制关系，如v1<v2，但是程序中的各个variable是相互独立的，那么可以转变一下，即：v1=v1, v2=v1+vd, 用v1和vd作为遗传变量。  

3. Makefile !  

4.
```
    FILE *f1=fopen("/root/rand.txt","w");
    for(i=0;i<100000;i++){
        fprintf(f1,"%d\n",rand()%10000);
    }
    fclose(f1);
```

5. ./src/mysga.c:31:7: warning: assignment makes pointer from integer without a cast [enabled by default]   path=get_current_dir_name(); 当出现这种报错的时候，因为#include<unistd.h>, 但没有声明get_current_dir_name()函数，声明：char *get_current_dir_name(void);  

