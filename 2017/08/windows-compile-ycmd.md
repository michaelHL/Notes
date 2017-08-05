## Windows 下编译YouCompleteMe(YCM)

### 原料

- [Clang for Windows (64-bit)](http://releases.llvm.org/4.0.1/LLVM-4.0.1-win64.exe)
- [Python](https://www.python.org/download/)
- [CMake](https://cmake.org/download/)
- [Visual Studio](https://www.visualstudio.com/)
- [MinGW GCC](https://sourceforge.net/projects/mingw-w64/)

测试时各版本如下:

| Entries       | Version                  |
| :----:        | :----:                   |
| Clang         | 3.9.0 x64                |
| Python        | 3.6.2 x64                |
| CMake         | 3.9.0 x64                |
| Visual Studio | 2017                     |
| MinGW GCC     | 7.1.0 x86_64-w64-mingw32 |

为防止环境路径干扰, 暂时删除 MSYS2 的两个环境路径
(包含 `clang`, `cmake` 和 `python`), 加入刚才安装的 Python、Cmake 路径
(Clang 的路径并不需要). Git 下载时挂了ss, 注意应使用 `http` 协议下载.
下面一套动作即可完成编译(`cmd` 中):

```
git clone http://github.com/Valloric/YouCompleteMe.git
cd YouCompleteMe
git submodule update --init --recursive
mkdir build
cd build
cmake -G "Visual Studio 15 Win64" ^
-DPATH_TO_LLVM_ROOT=D:/LLVM ^
-DPYTHON_INCLUDE_DIR=D:/Python/Python36/include ^
-DPYTHON_LIBRARY=D:/Python/Python36/libs/python36.lib ^
-DUSE_PYTHON2=OFF . ../third_party/ycmd/cpp
cmake --build . --target ycm_core --config Release
```

编译好之后, 在 VSCode 中使用 [you-complete-me](https://github.com/richard1122/vscode-youcompleteme)
插件尝试, 有稍许小问题(不提示系统库函数, 对引入的系统头文件警告等),
总体不影响使用, 而且支持跳转、peek, 完全可以替换之前介绍的基于 Clang 的补全,
基于 Ctags 的跳转了.
