## Windows下VSCode利用Ctags实现C/C++文件进行跳转

之前写了篇[Windows下VSCode利用Clang对C/C++进行补全](../07/msys-vscode-clang.md),
但谈到C/C++文件的跳转问题, 官方的插件[C/C++](https://github.com/Microsoft/vscode-cpptools/issues)
实在不敢恭维, 光代码提示出来一大堆无用的东西不说,
每次打开C/C++文件都会先烧CPU一刻钟在说, 看[issues](https://github.com/Microsoft/vscode-cpptools/issues/785#issuecomment-308880006)
发现这个插件会在后台一直parse, 应该是为debug服务的, 但是并用不到这个功能,
所以暂时强烈吐槽这个插件!:face_with_thermometer:(当然对事不对人)
