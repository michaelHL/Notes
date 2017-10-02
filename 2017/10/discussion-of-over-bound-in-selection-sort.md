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

对于待插入的元素 `arr[i]`, 前面有 `i-1` 个元素需要进行比对,
一旦比对结果为 `false` 即退出这个比对过程. 比如说我发现 `arr[4]` 小于 `arr[i]`,
那么说明 `arr[i]` 应介于 `arr[4]` 和 `arr[5]` 之间, 但注意 `arr[5]`
之前已经被 `arr[4]` 覆盖了, 所以最后将 `arr[i]` 的值赋值给 `arr[4]` 即可.
这里有个重要的边界问题, 由于循环终止条件为 `j >= 0`, 所以退出循环时候的 `j`
要么等于 `-1`, 要么使得 `arr[j] <= temp < arr[j+1]`.
比如退出循环的上一轮的结果为 `true`, 那么执行 `arr[1] = arr[0]`;
或者为 `false`: `arr[2] == arr[1]`, `arr[0] <= temp < arr[1]`.
所以结束循环之后的 `arr[i] = temp` 总能实现正常逻辑.

------------------------------------

现在对原代码进行修改, 因为感觉特意将
