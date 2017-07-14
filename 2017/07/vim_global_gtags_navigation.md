## Vim中使用GNU GLOBAL作为代码跳转工具

首先安装[GNU GLOBAL](https://www.gnu.org/software/global)工具:

- **MSYS2**
  ```
  pacman -S global
  ```
- **CentOS**
  ```
  yum install global
  ```

如果要生成C/C++文件的tag, `cd` 至 `/usr/include` 目录下,
直接执行 `gtags` 即可, 会在当前目录下生成三个文件 `GPATH`, `GRTAGS`, `GTAGS`.
在 `~/.bashrc` 中添加环境变量

```
export GTAGSLIBPATH=$GTAGSLIBPATH:/usr/include/
```

当然当前目录/工程也需要 `gtag`, 才能相互跳转.

### 推荐插件

- [jsfaint/gen_tags.vim](https://github.com/jsfaint/gen_tags.vim)
