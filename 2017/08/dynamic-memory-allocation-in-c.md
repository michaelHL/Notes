## C语言中动态分配数组

原帖: [http://blog.chinaunix.net/uid-11085590-id-2914577.html](http://blog.chinaunix.net/uid-11085590-id-2914577.html)

```c
int *a;
int N;
scanf("%d", &N);
a = (int *) malloc(N * sizeof(int));
....
free(a);
```

这样就动态分配了数组a[N]. 数组的长度N可输入确定, 也可用程序中的变量确定.
但要注意程序结束后要用free()将其释放, 否则内存会泄漏.

```c
#include <stdio.h>
#include <stdlib.h>
int main()
{
    int i = 0;
    int *a;
    int N;
    printf("Input array length: ");
    scanf("%d", &N);
    printf("\n");
    a = (int *) malloc(N * sizeof(int)); //int 可以用*a来代替

    for(i = 0; i < N; i++)
    {
        a[i] = i + 1;

        printf("%-5d", a[i]);
        if ((i + 1) % 10 == 0)
            printf("\n");
    }
    free(a);
    printf("\n");
    return 0;
}
```

**二维**

```c
#include <stdlib.h>
#include<stdio.h>
int main() {
    int nrows, ncolumns;
    scanf("%d,%d", nrows, ncolumns);

    // 区别的地方
    //为数组分配行数, 注意指针多了个*
    int **array = malloc(nrows * sizeof(*array));
    //注意分配的是整形指针的数量每行元素是个整形指针
    /*这里可以写成
    int **array;
    array = (int **)malloc(nrows * sizeof(int *)); //这里int可以写成**array
    */
    //对每行分配数组个数(就是二维数组的列数)
    for (i = 0; i < nrows; i++) {
        /*
        这里int*可以写成*array, 其实array是一个指向指针的指针变量,
        所以要将分配的内存转化为指针类型,
        在一台计算机中所有的指针变量分配的内存大小相同都是计算机的位数
        (就是地址线的条数,指针变量存放的是地址与地址线对应可以寻址)
        */
        array[i] = (int*)malloc(ncolumns * sizeof(int));
        for (l = 0; l < ncolumns; l++) {
            array[i][l] = ...
        }
    }
    //付初值以及处理过程
    free(array);
    return 0;
}
```

多维一个道理, 每增加一维, 输入数据就要多一个,
定义指针的时候就多一个\*, 且分配的时候也要多个\*还要多个for循环

**三维**

```c
#include <stdlib.h>
#include <stdio.h>
int main() {
    int rows, colnums, num;
    scanf("%d %d %d", rows, colnums, num);
    int ***p = malloc(rows * sizeof(*p));
    /*
     * 这里可以写成
     * int ***p;
     * p = (int ***)malloc(rows*sizeof(int**)); //int**可以写成*p
     */
    for (int i = 0; i < colnums; i++)
    {
        p[i] = (int**)malloc(colnums * sizeof(int*)); //**p
        for (int j = 0; j < num; j++)
        {
            p[i][j] = (int*)malloc(num * sizeof(int)); //这里可以写成*p
            for (r = 0; r < num; r++)
            {
                p[i][j][r] = ...
            }
        }
    }
    free(p);
    return 0;
}
```
