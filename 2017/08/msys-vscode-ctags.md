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

- [ctagsx](https://github.com/jtanx/ctagsx/issues)
- [CTags Support](https://github.com/jaydenlin/ctags-support)
- [ctags](https://marketplace.visualstudio.com/items?itemName=hcyang.ctags)

不过全字匹配的第三个插件竟然没放Github仓库地址, 而且唯独它获得4个:star2:,
对比其他两个插件发现功能几乎完全相同, 但第二个经测试发现并不能进行跳转,


