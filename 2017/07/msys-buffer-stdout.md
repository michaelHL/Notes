## 用 MinGW64/MinGW32 编译的程序输出被缓冲

上述问题在 MSYS2 中没有出现, 查阅资料发现 MinGW64 / MinGW32 的机制类似于管道,
所以一般情况下是被 buffer 的. 问题复现(MinGW64下):

```c
#include <stdio.h>

int main(void) {
    char text[100];
    printf("hello\n");
    scanf("%s", text);

    return 0;
}
```

其中应该最先被显示的 hello 并没有被打印出来, 而是等待用户输入回车之后
(相当于手动清空了缓冲区)才显示出来.

**解决方案**

1. 在 `printf` 之后清空缓冲区(不推荐)
2. 设置无缓冲: `setvbuf(stdout, 0, _IONBF, 0);`

另外, MSYS2 内含有 3 套工具链[install gcc on msys2](https://github.com/Alexpux/MSYS2-packages/issues/293):

- `msys2-devel`
- `mingw-w64-i686-toolchain`
- `mingw-w64-x86_64-toolchain`

---

### 2017-08-05 更新

在 MinGW32 / MinGW64 中, 使用 `winpty` 这个工具即可.

**参考**

- [[ mingw-Bugs-1262201 ] msys-1.0.10 stdin/stdout IO delay](http://mingw-notify.narkive.com/FCHi4Y3S/mingw-bugs-1262201-msys-1-0-10-stdin-stdout-io-delay)
- [printf before scanf doesn't show printf string before input](https://github.com/mintty/mintty/issues/218#issuecomment-108889703)
