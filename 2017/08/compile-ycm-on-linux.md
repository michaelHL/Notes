## Linux 下编译 Vim 插件 YouCompleteme (YCM)

#### 更新 GCC

见 [CentOS 下编译 GCC](compile-gcc-on-centos.md)
或 [CentOS 系统安装 GCC](../../stone-hills/how-to-install-gcc-on-centos-6.md).

#### 编译 YCM

```bash
cd ~/.vim/bundle/
git clone git@github.com:Valloric/YouCompleteMe.git
cd YouCompleteMe
git submodule update --init --recursive
mkdir -p ~/ycm_temp/
cd ~/ycm_temp/
wget http://releases.llvm.org/4.0.1/clang+llvm-4.0.1-x86_64-linux-gnu-debian8.tar.xz
tar -xvf clang+llvm-4.0.1-x86_64-linux-gnu-debian8.tar.xz
mkdir -p ~/ycm_build
cd ~/ycm_build
cmake -G "Unix Makefiles" \
-DPATH_TO_LLVM_ROOT=~/ycm_temp/clang+llvm-4.0.1-x86_64-linux-gnu-debian8 \
-DPYTHON_INCLUDE_DIR=/usr/include/python3.4m \
-DPYTHON_LIBRARY=/usr/lib64/libpython3.so \
-DUSE_PYTHON2=OFF \
. ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
cmake --build . --target ycm_core
```

首先下载大约 250 M 的 YCM, 下载上游 4.0.1 版本的 Clang.
利用 `cmake` 生成 `makefile`, 这里仅用 `Python 3.x` 版本, 所以使用
`-DUSE_PYTHON2=OFF` 选项.

#### C-family的语义分析支持

在根目录 `~` 下新建文件 [`.ycm_extra_conf.py`](src/.ycm_extra_conf.py).

#### .vimrc配置

记得在插件区中加入 `Plugin 'Valloric/YouCompleteMe'`.

```vim
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_server_python_interpreter = '/usr/bin/python3'
set completeopt=longest,menu
let g:ycm_semantic_triggers = {
\ 'c' : ['->', '.', ' ', '(', '[', '&'],
\ 'cpp,objcpp' : ['->', '.', ' ', '(', '[', '&', '::'],
\ 'perl' : ['->', '::', ' '],
\ 'php' : ['->', '::', '.'],
\ 'cs,java,javascript,d,vim,python,perl6,scala,vb,elixir,go' : ['.'],
\ 'ruby' : ['.', '::'],
\ 'lua' : ['.', ':']
\ }
```

### Ubuntu 16.04

`cmake` 部分有稍许变动:

```bash
cmake -G "Unix Makefiles" \
-DPATH_TO_LLVM_ROOT=~/ycm_temp/clang+llvm-4.0.1-x86_64-linux-gnu-debian8 \
-DPYTHON_INCLUDE_DIR=/usr/include/python3.5m \
-DPYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython3.5m.so \
-DUSE_PYTHON2=OFF \
. ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
```

### 致谢

- [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)
- [LLVM](https://clang.llvm.org/)
- [GCC](https://gcc.gnu.org/)
- [centos6.5升级gcc到4.9](http://blog.techbeta.me/2015/10/linux-centos6-5-upgrade-gcc/)
- [CentOS 6.5 升级 GCC 4.9.3](http://www.cnblogs.com/wanghaiyang1930/p/5608531.html)
- [Linux下GLIBCXX和GLIBC版本低造成的编译错误的解决方案](http://blog.csdn.net/officercat/article/details/39519265)
- [Centos7安装vim8.0 + YouCompleteMe](http://blog.csdn.net/nzyalj/article/details/75331822)
  - 该博主利用 `devtoolset` 来更新 GCC 版本, 不过在测试中无效
- [打造VIM利器](http://www.jianshu.com/p/e9cb158f7048)
