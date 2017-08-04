## CentOS下安装Vim插件YouCompleteme(YCM)

> 总的折腾时间有15小时, 遇到无数的坑, 看到自动补全的一刹那, 感动至极.

CentOS7.3 自带的 GCC 版本只有 4.8.5, 在之前无数次失败的安装中, 低版本是最大的锅.
整个的配置过程中, 工具的版本至关重要, Clang 依赖 GCC, 如用最新的 Clang-4.0.1,
那GCC的版本至少要 4.9.x. 所以第一步, 更新 GCC, 这里安装版本 4.9.4.

### 更新GCC

```bash
wget ftp://gcc.gnu.org/pub/gcc/releases/gcc-4.9.4/gcc-4.9.4.tar.bz2
tar -jxvf gcc-4.9.4.tar.bz2
./contrib/download_prerequisites
cd gcc-4.9.4/
./contrib/download_prerequisites
mkdir build
cd build
../configure --enable-checking=release --enable-languages=c,c++ --disable-multilib
make -j4
make install
```

这个 `make` 的过程耗费了1个小时, 当然还有个小坑: 记得安装 `bzip2`,
记得 `.tar.xz` 文件用 `tar -zxvf` 解压, `tar.bz2` 用 `tar -jxvf` 解压.

### 更新libstdc++

```bash
cp /usr/local/lib64/libstdc++.so.6.0.20 /usr/lib64
rm -rf /usr/lib64/libstdc++.so.6
ln -s /usr/lib64/libstdc++.so.6.0.20 /usr/lib64/libstdc++.so.6
strings /usr/lib64/libstdc++.so.6 | grep GLIBC
```

这个步骤之前如果输最后一个命令会发现 `GLIBCXX` 最高的版本号为 `3.4.19`,
而 Clang 3.9.0 已经需要至少 `3.4.20` 的 `libstdc++`, 所以有了上述操作.

### 编译YCM

```bash
cd ~/.vim/bundle/
git clone git@github.com:Valloric/YouCompleteMe.git
cd YouCompleteMe
git submodule update --init --recursive
mkdir -p ~/ycm_temp/
cd ~/ycm_temp/
wget http://releases.llvm.org/3.9.0/clang+llvm-3.9.0-x86_64-linux-gnu-debian8.tar.xz
tar -xvf clang+llvm-3.9.0-x86_64-linux-gnu-debian8.tar.xz
mkdir -p ~/ycm_build
cd ~/ycm_build
cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=~/ycm_temp/clang+llvm-3.9.0-x86_64-linux-gnu-debian8 . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
cmake --build . --target ycm_core
```

分步下载, 利用 LLVM-Clang 编译.

### C-family的语义分析支持

在根目录 `~` 下新建文件 [`.ycm_extra_conf.py`](src/.ycm_extra_conf.py).

### .vimrc配置

```vim
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_confirm_extra_conf = 0
set completeopt=longest,menu
```
