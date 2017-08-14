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

YCM分步下载, 下载 3.9.0 版本的 Clang, 再利用其编译.

### C-family的语义分析支持

在根目录 `~` 下新建文件 [`.ycm_extra_conf.py`](src/.ycm_extra_conf.py).

### .vimrc配置

记得在插件区中加入 `Plugin 'Valloric/YouCompleteMe'`.

```vim
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_confirm_extra_conf = 0
set completeopt=longest,menu
```

### 额外问题

- 一定概率碰到提示 `python interpreter` 的问题, 在 `.vimrc` 设置 `python`
  路径即可:

  ```vim
  let g:ycm_server_python_interpreter = '/usr/bin/python2'
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
