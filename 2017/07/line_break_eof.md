## Line Break 初窥

### Linux下

利用

```
cat > cat.txt
In sleep he sang to me
^D
cat cat.txt
```

得到的输出是非常「正常」的:

```
[xxx]$ cat cat.txt
In sleep he sang to me
[xxx]$ 
```

由于敲完一行后进行了回车, 所以不能排除这个 `\n` 是人为加上去的可能,
下面用 `vim` 编辑同样的文字生成文件 `vim.txt`(默认设置下),
不键入最后的 <kbd>Enter</kbd>, 发现输出结果同上.
其他的工具未尝试, 但猜想Linux下的工具生成的文本文件,
会自动加上 `\n`, 也就是 `line break`. 这个猜想在
[What's the point in adding a new line to the end of a file?](https://unix.stackexchange.com/questions/18743/whats-the-point-in-adding-a-new-line-to-the-end-of-a-file)
第一个回答中得到证实.  
下面人为破坏这个末尾的 `\n`, 观察是否会出现异样.
如果在 `vim` 中设置 `:set binary`, `:set noeol`并保存,
`cat vim.txt` 的结果如下:

```
In sleep he sang to me[xxx]$
```

也就是说「成功」将最后一个 `\n` 给抹去了, 当然这种操作是不应该的,
大量论坛网站的网友会抱怨php处理无 `endline` 文件会报错,
说明行末自动加 `\n` 是很重要的机制, 不应修改它.

将上述没有 `eof` 的文件重命名为 `vim_no_eof.txt`,
利用 `wc -l` 检测文件的行数:

```
wc -l vim.txt
1 vim.txt
wc -l vim_no_eof.txt
0 vim_no_eof.txt
```

大概已经能够猜测 `wc` 的工作机理了, `man wc` 的部分内容如下:

```
NAME
   wc - print newline, word, and byte counts for each file

SYNOPSIS
   wc [OPTION]... [FILE]...
   wc [OPTION]... --files0-from=F

DESCRIPTION
   Print newline, word, and byte counts for each FILE,
   and a total line if more than one FILE is specified.
   With no FILE, or when FILE is -, read standard input.
   A word is a non-zero-length sequence of characters
   delimited by white space.
   The options below may be used to select which counts are printed,
   always in the following order: newline, word, character, byte,
   maximum line length.

   -c, --bytes
          print the byte counts

   -m, --chars
          print the character counts

   -l, --lines
          print the newline counts
```

可见, `wc` 统计的是 `newline` 的个数, 也就是说, 统计 `\n` 的个数.

### Windows下

#### MSYS2 开发环境

首先在 MSYS2 的环境下, 重复上面在Linux下的操作,
新建文件 `cat.txt`, `vim.txt`, `vim_no_eof.txt`,
再分别 `cat`, 出现的结果Linux下情况相同. 利用Notepad++查看不可见字符,
发现 `vim.txt` 以及 `cat.txt` 末尾均含有 `LF` 字样, 即 `\n`.

现利用程序输出文件:

```c
// print_2_lines.c

#include <stdio.h>

int main(void) {
    printf("In sleep he sang to me\n");
    printf("In dreams he came");

    return 0;
}
```

发现 `cat` 的结果不好看:

```
In sleep he sang to me
In dreams he came[xxx]$
```

将输出导出至文件, 利用Notepad++查看文件:

```
In sleep he sang to me<LF>
In dreams he came
```

#### MinGW-W64 环境

输出本机 `gcc` 配置:

```
gcc (i686-posix-dwarf-rev0, Built by MinGW-W64 project) 5.4.0
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

同样执行同 MSYS2 环境中操作(终端变成了lowbie的`cmd`),
发现结果竟然变的「正常」:

```
In sleep he sang to me
In dreams he came
xxx>
```

但如果在 MSYS2 的终端("mintty")中运行, 仍然在最后一行不存在换行符,
由此可见这锅该 `cmd` 背. 输出到文件, 在Notepad++里面观察:

```
In sleep he sang to me<CR><LF>
In dreams he came
```

完全符合DOS下的换行标准.

### 在程序中输出文件

#### Linux下

通过重定向文件流函数 `freopen`:

```c
#include <stdio.h>

int main(void) {
    freopen("output.txt", "w", stdout);
    printf("In sleep he sang to me\n");
    printf("In dreams he came");

    return 0;
}
```

结果不出所料, 提示符紧跟着最后一行的输出,
将第二个 `printf` 中输出的字符串最后加上 `\n`, 显示正常.

猜想这里是因为 `freopen` 相当于重定向, 并没有在程序层面上进行文件读写,
所以将 `freopen` 换为 `fopen`:

```c
#include <stdio.h>
#include <stdlib.h>

int main(void) {
    FILE *fp;

    fp = fopen("fw_out.txt", "w+");
    fprintf(fp, "In sleep he sang to me\n");
    fprintf(fp, "In dream he came");

    return 0;
}
```

发现表现结果与之前相同, 且 `w+` 与 `w+b` 效果相同.

#### Windows下

- MSYS2 环境下的表现与Linux下完全相同
- MinGW-W64 环境下, 将 `w+` 换成 `w+b`, 在 Notepad++ 视图中发现,
  后者的文件与Linux下相同, 即显示 `LF` 而不是 `CR` `LF`.

作为扩展, 输出更多的行, 分别在Linux下和 MinGW-W64 环境下进行试验,
发现在二进制模式下, MinGW-W64 环境的表现与Linux相同,
同时输出的文本在Notepad打开时会连成一片, 因为 `CR` `LF` 的缘故.

---

### 总结

1. Linux将 `\n` 视作 `newline`, 也就是说,
   当Linux下的程序遇到一个 `\n`, 便会认为读了一行,
   下面读取的内容就是作为新的一行(newline);
   Windows下的 `\r\n` 相当于Linux下的 `\n`,
   所以Windows自带的Notepad在打开以 `\n`
   为换行符的文件时会不知道从何处开始为新的一行, 所以连成一片.
   不过可以通过Notepad++、Sublime Text等机智的文本编辑器来判断文本文件类型.
2. 通过 `printf`, 编译器会自动处理 newline 符号,
   所以在Windows下, 即便在 `printf` 中输出 `\n`,
   通过输出文件可知 `\n` 被转换成了 `\r\n`.
3. 如果在文件读写函数中将模式改为二进制模式, 这对Linux没有任何影响,
   因为这两个模式在Linux下是无差异的, 而在Windows下,
   模式中加上 `b`, 程序会忠诚地原样输出字符.
   所以二进制模式中, `printf` 中的 `\n` 需要手动换为 `\r\n` 才符合 Win-Style.