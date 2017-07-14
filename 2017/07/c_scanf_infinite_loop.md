## C语言中scanf接受不当参数陷入死循环问题

问题很容易:

> 对一列数据进行求和, 但数据中包含非数字的输入.

```c
#include <stdio.h>

int main() {
    long num;
    long sum = 0l;
    char chTest;

    while ((chTest = getchar()) != EOF) {
        ungetc(chTest, stdin);
        if (scanf("%ld", &num) == 0) {
            fflush(stdin);
            continue;
        }
        fflush(stdin);
        sum += num;
    }
    printf("sum = %ld\n", sum);

    return 0;
}
```

当然这个程序不完美, 其中 `fflush(stdin)` 其实是个未定义行为,
极其不推荐, 虽然在windows下是可行的.

首先判断输入是否为 `EOF`, 如果不是则放回输入流.
再判断是否成功读取一个 `long` 型数值, 如果没有, 清空输入流(劣质做法),
