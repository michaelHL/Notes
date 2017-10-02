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

现在对原代码进行修改, 因为感觉特意将 `arr[j + 1] = temp` 写在一行不是那么 nice,
所以尝试下面的代码:

```c
void insertion_sort(int *arr, int size) {
    int i, j, temp;
    for (i = 1; i < size; i++) {
        temp = arr[i];
        for (j = i - 1; j >= -1; j--) {
            if (arr[j] > temp) {
                arr[j + 1] = arr[j];
            } else {
                arr[j + 1] = temp;
                break;
            }
        }
    }
}
```

这里初始的想法比较简单, 如果对比的结果为 `true`, 那么同之前的代码,
否则, 比如说发现 `arr[2] <= temp`, 说明 `temp` (也就是之前 `arr[i]` 的一个副本)
应该安插在 `arr[2]` 与 `arr[3]` 之间, 由于此时的 `arr[4] == arr[3]`,
所以将 `arr[3] = temp` 即可. 然而如果到了边界上, 也就是如果到了判断到 `j = 0`
的时候, 如果结果为 `true`, 那么 `arr[1] = arr[0]`. 如果循环条件的下界为 `0`,
那么这次覆盖之后就会退出循环, 且 `i+1=0`, 不会走 `arr[j + 1] = temp` 这个分支,
所以程序错误, 会出现类似下面的结果:

```
90 89 18 44 83 49 46 22 90 24 28 81 99 26 89 46 15 45 93 41
90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 93 99
```

当然, 如果刚才的判断结果为 `false` 的话, 也就是恰好 `arr[0] <= temp < arr[1]`,
这时的 `arr[j + 1] = temp` 工作正常.
这就是为什么这里循环条件的下界为 `-1` 的原因, 虽然会产生下标为 `-1` 的情况,
但这样下来还是可以获得同之前正确版本的代码一样的结果的,
所以这里研究为什么下标取负值也能正常运行.

## 下标为负?

`arr[-1]` 可以理解成 `*(arr - 1)`, 设想之前的问题版本中, `arr - 1`
这个内存地址里面按照 `int` 来读取的数值为 `0`, 那么在上面的问题代码中,
由于输入的随机数均为正, 所以 `arr[-1] > temp` 总是为 `false`,
总是能在 `j = -1` 的时候将 `arr[0]` 赋值为 `temp`, 实现正常逻辑.

**下面来证实这个观点.**

首先做试验, 证实下标为负是在一些编译器下是可以正常工作的 (`clang version 5.0.0`
, `clang version 5.0.0` 下正常, `VS2017` 失败):

```c
#include <stdio.h>

int main() {
    int right = 10, arr[5] = {0}, left = 9;
    printf("&arr:  %p\n", arr);
    printf("left:  %p\n", &left);
    printf("right: %p\n", &right);
    printf("arr[-1]=%d\n", arr[-1]);

    return 0;
}
```

这里面涉及变量在内存中高地址低地址的排布, 有点超出个人理解范围,
但在试验中确实打印出 `arr[-1]` 的值为 9.

同样, 可以把这个想法搬到刚才的问题算法上去, 在 `main` 函数中刚为 `testarr`
申请内存之后, 加上如下语句:

```c
srand((unsigned)time(&t));
testarr = (int *)malloc(sizeof(int) * rand_len);

/* 搞事情 */
int *left_testarr = testarr - 1;
*left_testarr = 9999;
/* 搞事情 */

for (int i = 0; i < rand_len; i++) {
    testarr[i] = rand() % rand_max_num;
```

不出意料, 结果为:

```
40 72 37 20 78 58 78 91 94 6 87 89 35 21 95 1 27 88 59 90
9999 9999 9999 9999 9999 9999 9999 40 58 59 72 78 78 87 88 89 90 91 94 95
```

所以问题代码之所以通过的原因是因为恰好 `arr[-1] = 0` 罢了.

## 改进

既然只在 `0` 处出问题, 特殊对待即可, 这里仅写出关于 `j` 的循环部分
(感谢群友 `酒醉过后  石头剪刀布`):

```c
for (j = i - 1; j >= 0; j--) {
    if (arr[j] > temp) {
        if (j == 0)
            arr[j] = temp;
        arr[j + 1] = arr[j];
    } else {
        arr[j + 1] = temp;
        break;
    }
}
```
