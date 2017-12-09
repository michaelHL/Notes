## 编译 Vim 8.0

### CentOS 7.3 下编译过程

> 一路遇到了不少坑, 遇到奇奇怪怪的错误, 没有依依记录, 直接写下成功的编译过程.

1. 系统用U盘进行安装的, 自带了个 `python2.7`. 首先安装必要包(可能不全)

   ```sh
   yum install mercurial ncurses-devel ruby ruby-devel lua lua-devel luajit python-devel python34 python34-devel
   ```

1. `git clone` [Vim](https://github.com/vim/vim) 的仓库

   ```sh
   git clone https://github.com/vim/vim.git
   ```

   或者自己 clone 到码云的仓库:

   ```sh
   git clone https://gitee.com/shinemic/vim.git
   ```

1. 开始各种配置:

   ```sh
   ./configure --with-features=huge \
               --enable-rubyinterp=yes \
               --enable-luainterp=yes \
               --enable-perlinterp=yes \
               --enable-pythoninterp=yes \
               --enable-python3interp=yes \
               --with-python-config-dir=/usr/lib64/python2.7/config \
               --with-python3-config-dir=/usr/lib64/python3.4/config-3.4m \
               --enable-fontset=yes \
               --enable-cscope=yes \
               --enable-multibyte \
               --disable-gui \
               --enable-fail-if-missing \
               --prefix=/usr/local \
               --with-compiledby='Professional operations'
   ```

   对其中的参数稍作解释:

   - `--enable-fail-if-missing` 表示一旦出现配置错误, 则报错并停下来,
     这时候可以看到什么方面没有配置好, 方便排错, 否则还要往回翻看一大串的信息
   - `...interp=yes` 表示加入某某支持
   - 在加入对 `python` 的支持中, 出现了各种问题, 最终发现是没有安装 `python-dev`
     以及 `python34-devel`. 同样 `lua` 也要安装 `lua-devel`.
     另外 `...-config-dir` 也是很重要的, 默认情况下 Vim 是找不到他们的配置路径的

1. 编译.

   ```sh
   make
   make install
   ```

1. 开耍. `vim --version`

   ```sh
   VIM - Vi IMproved 8.0 (2016 Sep 12, compiled Aug  3 2017 06:43:08)
   Included patches: 1-844
   Compiled by root@Dorawk-workstation
   Huge version without GUI.  Features included (+) or not (-):
   +acl             +file_in_path    +mouse_sgr       +tag_old_static
   +arabic          +find_in_path    -mouse_sysmouse  -tag_any_white
   +autocmd         +float           +mouse_urxvt     -tcl
   -balloon_eval    +folding         +mouse_xterm     +termguicolors
   -browse          -footer          +multi_byte      -terminal
   ++builtin_terms  +fork()          +multi_lang      +terminfo
   +byte_offset     +gettext         -mzscheme        +termresponse
   +channel         -hangul_input    +netbeans_intg   +textobjects
   +cindent         +iconv           +num64           +timers
   -clientserver    +insert_expand   +packages        +title
   -clipboard       +job             +path_extra      -toolbar
   +cmdline_compl   +jumplist        +perl            +user_commands
   +cmdline_hist    +keymap          +persistent_undo +vertsplit
   +cmdline_info    +lambda          +postscript      +virtualedit
   +comments        +langmap         +printer         +visual
   +conceal         +libcall         +profile         +visualextra
   +cryptv          +linebreak       +python/dyn      +viminfo
   +cscope          +lispindent      +python3/dyn     +vreplace
   +cursorbind      +listcmds        +quickfix        +wildignore
   +cursorshape     +localmap        +reltime         +wildmenu
   +dialog_con      +lua             +rightleft       +windows
   +diff            +menu            +ruby            +writebackup
   +digraphs        +mksession       +scrollbind      -X11
   -dnd             +modify_fname    +signs           -xfontset
   -ebcdic          +mouse           +smartindent     -xim
   +emacs_tags      -mouseshape      +startuptime     -xpm
   +eval            +mouse_dec       +statusline      -xsmp
   +ex_extra        -mouse_gpm       -sun_workshop    -xterm_clipboard
   +extra_search    -mouse_jsbterm   +syntax          -xterm_save
   +farsi           +mouse_netterm   +tag_binary
      system vimrc file: "$VIM/vimrc"
        user vimrc file: "$HOME/.vimrc"
    2nd user vimrc file: "~/.vim/vimrc"
         user exrc file: "$HOME/.exrc"
          defaults file: "$VIMRUNTIME/defaults.vim"
     fall-back for $VIM: "/usr/share/vim"
   Compilation: gcc -c -I. -Iproto -DHAVE_CONFIG_H
   -g -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
   Linking: gcc   -L. -Wl,-z,relro -fstack-protector -rdynamic -Wl,-export-dynamic
   -Wl,--enable-new-dtags -Wl,-rpath,/usr/lib64/perl5/CORE   -L/usr/local/lib -Wl,
   --as-needed -o vim        -lm -ltinfo -lnsl  -lselinux   -ldl  -L/usr/lib -llua
   -Wl,--enable-new-dtags -Wl,-rpath,/usr/lib64/perl5/CORE  -fstack-protector
   -L/usr/lib64/perl5/CORE -lperl -lresolv -lnsl -ldl -lm -lcrypt -lutil -lpthread
   -lc    -lruby -lpthread -lrt -ldl -lcrypt -lm
   ```

### MSYS2 下编译过程

首先编译 `lua`:

```
curl -R -O http://www.lua.org/ftp/lua-5.3.4.tar.gz
tar zxf lua-5.3.4.tar.gz
cd lua-5.3.4
pacman -S ncurses-devel libcrypt-devel gettext-devel
make mingw && cd .. && make install
```

配置:

```bash
./configure --with-features=huge \
            --enable-luainterp=yes \
            --enable-perlinterp=yes \
            --enable-pythoninterp=yes \
            --enable-python3interp=yes \
            --with-lua-prefix=/usr/local \
            --enable-fontset=yes \
            --enable-cscope=yes \
            --enable-multibyte \
            --disable-gui \
            --enable-fail-if-missing \
            --prefix=/usr/local \
            --with-compiledby='Professional operations'
```

### Ubuntu 16.04 下编译过程

```sh
sudo apt-get install libncurses5-dev libgnome2-dev \
                     libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
                     libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
                     python3-dev ruby-dev lua5.1 lua5.1-dev liblua5.1-dev libperl-dev git
./configure --with-features=huge \
            --enable-luainterp=yes \
            --enable-rubyinterp=yes \
            --enable-perlinterp=yes \
            --enable-pythoninterp=yes \
            --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
            --enable-python3interp=yes \
            --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
            --enable-fontset=yes \
            --enable-cscope=yes \
            --enable-multibyte \
            --enable-fail-if-missing \
            --enable-gui=gtk2 \
            --prefix=/usr/local \
            --with-compiledby='Professional operations'
```

### vimrc

- Linux: [`vimrc`](../src/.vimrc)
- MSYS: [`vimrc`](../src/_vimrc)

### 注意事项

- 在 `CentOS` 机器上若安装其它版本的 `Python`, 可能导致各种与 `Python` 相关的问题,
  在编译的时候灵活取舍 `python` 与 `python3` 选项即可
- 若不能 `configure`, 执行 `make distclean`
