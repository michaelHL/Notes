## C语言中scanf接受不当参数陷入死循环问题

### 问题初探

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
极不推荐, 虽然在windows下是可行的.

首先判断输入是否为 `EOF`, 如果不是则放回输入流.
再判断是否成功读取一个 `long` 型数值, 如果没有, 清空输入流(劣质做法).
注意第二个 `fflush` 是必要的, 否则不会清除缓冲区的 `\n`,
在下一轮循环中, `getchar` 会读取这个 `\n`, 并跳过 `if` 判断,
又计算了一次 `sum += num`, 导致结果错误. 所以强制刷新缓冲区或者利用 `getchar`
可以解决这个问题.

不过 `fflush(stdin)` 在除 Windows 外的其他平台上是未定义行为,
所以寻找更有效的解决方案.

参考链接:

- [Why is scanf() causing infinite loop in this code?](https://stackoverflow.com/questions/1716013/why-is-scanf-causing-infinite-loop-in-this-code)
- [Using fflush(stdin)](https://stackoverflow.com/questions/2979209/using-fflushstdin)


### 清空输入流

由于标准输入流 `stdin` 及 标准输出流 `stdout` 为行缓冲,
所以一般输入用 <kbd>enter</kbd> 来 push 输入缓冲区的数据至输入流,
但 `fflush` 一般作用于 `stdout`, 也就是常用的手动输出 `stdout` 的内容.

参考
[Replacement of fflush(stdin)](https://stackoverflow.com/questions/6277370/replacement-of-fflushstdin)
以及
[alternative for fflush(stdin)](https://cboard.cprogramming.com/c-programming/50037-alternative-fflush-stdin.html),
应用

```c
while((c = getchar()) != '\n' && c != EOF)
```

来清空输入流.

### 更好的做法

根据[回答](https://stackoverflow.com/a/6277391/4154610),
应使用 `fgets` 以及 `sscanf` 来替换一般的 `scanf`.

**TO BE CONTINUED**
