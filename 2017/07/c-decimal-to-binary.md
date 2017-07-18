## C语言中转二进制

参考来源: [Binary representation of a given number](http://www.geeksforgeeks.org/binary-representation-of-a-given-number)

### 循环

数字在计算机内部存储的方式为二进制, 所以不用费心去从十进制生成二进制了,
设法原样输出二进制即可.

```c
void bin(int n) {
    unsigned i;
    for (i = 1 << 31; i > 0; i /= 2)
        (n & i) ? printf("1") : printf("0");
}
```

这是网站上的代码. 直接从 `1000|0000|...` 开始,
逐步向低位进行按位与运算, 注意这里的处理是 `i /= 2`, 当然也可以 `i >> 1`.
边界情况为 `0000|0000|...|0001`, 所以保证 `i > 0` 即可.

或者, 令变元表示位数:

```c
void bin(int n) {
    unsigned i;
    for (i = 31; i >= 0; i--)
        printf("%c", number & (1 << i) ? '1' : '0');
}
```

**注** 原帖中的参数为 `unsigned`, 但显然带符号整型也可以.

### 递归

**TO BE CONTINUED**

```c
void bin(unsigned n) {
    if (n > 1) bin(n / 2);
    printf("%d", n % 2);
}
```
