## Windows下VSCode利用Ctags实现C/C++文件进行跳转

之前写了篇[Windows下VSCode利用Clang对C/C++进行补全](../07/msys-vscode-clang.md),
但谈到C/C++文件的跳转问题, 官方的插件[C/C++](https://github.com/Microsoft/vscode-cpptools/issues)
实在不敢恭维, 光代码提示出来一大堆无用的东西不说,
每次打开C/C++文件都会先烧CPU一刻钟在说, 看
[issues](https://github.com/Microsoft/vscode-cpptools/issues/785#issuecomment-308880006)
发现这个插件会在后台一直parse, 应该是为debug服务的, 但是并用不到这个功能,
所以暂时强烈吐槽这个插件!:face_with_thermometer:(当然还是要感谢开发者辛勤的付出)

想到Vim里面一般用Ctags作为跳转的必要工具, 于是到
[Extensions](https://marketplace.visualstudio.com/VSCode)
里面搜索一番, 找到三个类似的插件:

- [ctagsx](https://github.com/jtanx/ctagsx)
- [CTags Support](https://github.com/jaydenlin/ctags-support)
- [ctags](https://marketplace.visualstudio.com/items?itemName=hcyang.ctags)

不过全字匹配的第三个插件竟然没放Github仓库地址, 而且唯独它获得4个:star:,
对比其他两个插件发现功能几乎完全相同, 但第二个经测试发现并不能进行跳转,
所以下面对ctagsx这个插件进行配置(其实并没有什么配置).

### 配置

既然系统上有了[MSYS2](www.msys2.org), 那干脆用它编译下Ctags,
进[Ctags官网](http://ctags.sourceforge.net), 直接下载源文件
(`ctags-x.tar.gz`), 文件版本为 `5.8`, 进行下面的操作:

```bash
tar -zxvf ctags-5.8.tar.gz
cd ctags-5.8
./configure --prefix=/usr/local
make
make install
```

等待编译的同时可以随手在VSCode中安装下ctagsx插件.
如果一切顺利, `which ctags` 应显示 `/usr/local/bin/ctags`.

进入工程目录, 作者建议的命令为

```bash
ctags --tag-relative --extra=f -R .
```

不过精简成 `ctags -R .` 发现也是可以的. (ctags细节以后再作深入),
那么在VSCode里面用 <kbd>C-t</kbd>, <kbd>A-t</kbd> 就能跳过去/跳回来了.
不过感觉这两个键容易被占用(如果装了Vim插件会发现 <kbd>C-t</kbd> 是有功能的),
所以我改成了与Vim中相同的按键 <kbd>C-]</kbd> 和 <kbd>C-o</kbd>.

### 开耍





