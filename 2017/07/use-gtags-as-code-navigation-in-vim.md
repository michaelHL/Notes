## Vim 中使用 GNU GLOBAL 作为代码跳转工具

### 安装 [GNU GLOBAL](https://www.gnu.org/software/global)工具

- **MSYS2**
  ```
  pacman -S global
  ```
- **CentOS**
  ```
  yum install global
  ```

### 生成 taglist

如果要生成 C / C++ 文件的tag, `cd` 至 `/usr/include` 目录下,
直接执行 `gtags` 即可, 会在当前目录下生成三个文件 `GPATH`, `GRTAGS`, `GTAGS`.
在 `~/.bashrc` 中添加环境变量

```
export GTAGSLIBPATH=$GTAGSLIBPATH:/usr/include/
```

当然当前目录/工程也需要 `gtags`, 才能相互跳转.

### Vim 设置

加载插件 `aceofall/gtags.vim`.
或者拷贝GNU GLOBAL工具自带的两个 `.vim` 插件亦可.
`~/.vimrc` 文件设置:

```
set cscopetag
set cscopeprg='gtags-cscope'

let GtagsCscope_Auto_Load = 1
let CtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1
```

### 推荐插件

- [jsfaint/gen_tags.vim](https://github.com/jsfaint/gen_tags.vim)
