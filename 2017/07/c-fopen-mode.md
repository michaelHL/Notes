## C语言中fopen函数模式浅析

一般的, C语言中 `fopen` 函数有`r`, `w`, `a`, `r+`, `w+`, `a+`
以及它们的二进制模式. 这里主要探索 `+` 的用处.

直接上一段代码:

```c
#include <stdio.h>
#include <stdlib.h>

void printFile(FILE *);

int main() {
    FILE *fp;

    fp = fopen("test.txt", "w");
    fprintf(fp, "line 1\n");
    fclose(fp);

    puts("test.txt: (system cat)");
    system("cat test.txt");

    puts("test.txt: (a)");
    fp = fopen("test.txt", "a");
    printFile(fp);
    fclose(fp);

    puts("test.txt: (a+)");
    fp = fopen("test.txt", "a+");
    printFile(fp);
    fclose(fp);

    puts("test.txt: (w)");
    fp = fopen("test.txt", "w");
    puts("before:");
    printFile(fp);
    fprintf(fp, "line 2\n");
    puts("after:");
    printFile(fp);
    fclose(fp);

    puts("test.txt: (w+)");
    fp = fopen("test.txt", "w+");
    puts("before:");
    printFile(fp);
    fprintf(fp, "line 2\n");
    fflush(fp);
    puts("test.txt: (system cat)");
    system("cat test.txt");
    puts("after:");
    fseek(fp, 0, SEEK_SET);
    printFile(fp);
    fclose(fp);

    puts("test.txt: (r)");
    fp = fopen("test.txt", "r");
    puts("before:");
    printFile(fp);
    fprintf(fp, "line 3\n");
    puts("after:");
    fseek(fp, 0, SEEK_SET);
    printFile(fp);
    fclose(fp);

    puts("test.txt: (r+)");
    fp = fopen("test.txt", "r+");
    puts("before:");
    printFile(fp);
    fprintf(fp, "line 3\n");
    puts("after:");
    fseek(fp, 0, SEEK_SET);
    printFile(fp);
    fclose(fp);

    return 0;
}

void printFile(FILE *fp) {
    char c;
    if (fp) {
        while ((c = getc(fp)) != EOF)
            putchar(c);
    }
}
```

上面的程序中, 需要注意几点:

- `fseek` 函数对于上面的测试至关重要, 因为 `fprintf` 函数在将内容输入至流中后,
  指针停留在最后, 相当于模式 `a` 的行为(在其后附加新的内容).
  否则, 将得不到任何输出, 产生误判.
- `fflush` 函数清空缓冲区, 强制将buffer中的内容写入文件,
  这样利用系统函数才能正确打印.
- `w+`, `a+` 在原有的只能往文件流里面写入的基础上, 增加了读取的功能,
  同样, `r+` 既能读又能写.
- 二进制模式下, 可参考之前的文章[Line Break 初窥](c-line-break-eof.md)
