## Windows 下编译 YouCompleteMe(YCM)

### 原料

- [Clang for Windows (64-bit)](http://releases.llvm.org/4.0.1/LLVM-4.0.1-win64.exe)
- [Python](https://www.python.org/download/)
- [CMake](https://cmake.org/download/)
- [Visual Studio](https://www.visualstudio.com/)
- MinGW GCC (测试用 MSYS2 系统里面的 MinGW64 替代)

测试时各版本如下:

| Entries       | Version    |
| :----:        | :----:     |
| Clang         | 4.0.1 x64  |
| Python        | 2.7.10 x64 |
| CMake         | 3.9.0 x64  |
| Visual Studio | 2017       |
| MinGW GCC     | 7.1.0      |
| Git           | -          |

### 编译

为防止环境路径干扰, 暂时删除 MSYS2 的两个环境路径( `/mingw64/bin`,
`/usr/bin` 包含 `clang`, `cmake` 和 `python`), 加入刚才安装的 Cmake 路径
(Python, Clang 的路径并不需要). Git 下载时挂了ss, 注意应使用 `http` 协议下载.
下面一套动作即可完成编译(`cmd` 中):

```bash
git clone http://github.com/Valloric/YouCompleteMe.git
cd YouCompleteMe
git submodule update --init --recursive
mkdir build
cd build
cmake -G "Visual Studio 15 Win64" ^
-DPATH_TO_LLVM_ROOT=D:/LLVM ^
-DPYTHON_INCLUDE_DIR=D:/Python/Python27/include ^
-DPYTHON_LIBRARY=D:/Python/Python27/libs/python27.lib ^
. ../third_party/ycmd/cpp
cmake --build . --target ycm_core --config Release
```

这里明确指明了 `LLVM` 的目录以及 `Python` 的库, 当然如果要在 `Python 3.x`
下编译, 需将 `cmake` 部分改为:

```bash
cmake -G "Visual Studio 15 Win64" ^
-DPATH_TO_LLVM_ROOT=D:/LLVM ^
-DPYTHON_INCLUDE_DIR=D:/Python/Python36/include ^
-DPYTHON_LIBRARY=D:/Python/Python36/libs/python36.lib ^
-DUSE_PYTHON2=OFF . ../third_party/ycmd/cpp
```

上述的 `Python`, `LLVM`, `Visual Studio`, `CMake` 的版本会直接影响编译结果,
从多次编译的结果上看, `LLVM` 的版本宜 `3.9+`,
且 `Python` 和 `LLVM` 的位数需匹配, 而且 `Python 2.7.11`, `Python 2.7.13`
版本即便编译成功, 在后续的使用中仍会出问题.

### 测试

编译好之后, 在 VSCode 中使用 [you-complete-me](https://github.com/richard1122/vscode-youcompleteme)
插件尝试, 有稍许小问题(不提示系统库函数, 但按下 `.` 之后才有提示.
对引入的系统头文件警告等), 总体不影响使用, 而且支持跳转、peek,
完全可以替换之前介绍的基于 Clang 的补全、 基于 Ctags 的跳转了.

附上 VSCode 中的配置:

```json
"ycmd.path": "E:\\YouCompleteMe\\third_party\\ycmd",
"ycmd.confirm_extra_conf": true,
"ycmd.global_extra_config": "F:\\WorkingDirectory\\Configuration\\common\\_ycm_extra_conf.py",
"ycmd.python": "D:\\Python\\Python27\\python.exe",
```

以及 YCM 所需的 [`_ycm_extra_conf.py`](src/_ycm_extra_conf.py).

### 摘记

原料里面的各工具的版本试了又试, `Python 2.7.10` + `LLVM Clang 4.0.1`
貌似是最佳组合, 但在 VSCode 中我还是使用之前介绍的基于 `Clang` 的补全
(虽然没有跳转功能).

### 链接

- [CentOS7.3编译Vim记录](centos-compile-install-vim-8.md)
- [CentOS下安装Vim插件YouCompleteme(YCM)](centos-install-ycm.md)
- [Windows下VSCode利用Clang对C/C++进行补全](../07/msys-vscode-clang.md)
- [Windows下VSCode利用Ctags实现C/C++文件进行跳转](msys-vscode-ctags.md)
