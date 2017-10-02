## 一段插入排序代码引发的思考

根据 Thomas H. Cormen 的《算法基础》一书第三章中插入排序算法的伪代码:

> - **程序** INSERTION-SORT(A, n)
> - **输入、结果:**
>   - A: 一个数组
>   - n: 待排序的数组 A 中的元素个数
> 1. 令 i 从 2 到 n 一次取值:
>    1. key 被赋值为 A[i], 将 j 赋值为 i - 1;
>    1. 只要 j > 0 并且 A[j] > key, 执行如下操作:
>       1. 将 A[j + 1] 赋值为 A[j];
>       1. 令 j 自减 1;
>    1. A[j + 1] 被赋值为 key.

根据此伪码写一段「正常」的插入排序代码:

```c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void insertion_sort(int *arr, int size) {
    int i, j, temp;
    for (i = 1; i < size; i++) {
        temp = arr[i];
        for (j = i - 1; j >= 0; j--) {
            if (arr[j] > temp) {
                arr[j + 1] = arr[j];
            } else {
                break;
            }
        }
        arr[j + 1] = temp;
    }
}

void printarr(int *arr, int size) {
    for (int i = 0; i < size; i++) {
        if (i)
            printf(" %d", arr[i]);
        else
            printf("%d", arr[i]);
    }
    putchar('\n');
}

int rand_len     = 20;
int rand_max_num = 100;

int main(void) {
    time_t t;
    int *testarr;

    srand((unsigned)time(&t));
    testarr = (int *)malloc(sizeof(int) * rand_len);
    for (int i = 0; i < rand_len; i++) {
        testarr[i] = rand() % rand_max_num;
    }

    printarr(testarr, rand_len);
    insertion_sort(testarr, rand_len);
    printarr(testarr, rand_len);

    return 0;
}

```

