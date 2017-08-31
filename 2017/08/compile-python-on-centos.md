## CentOS 下编译 Python

CentOS 7.3 自带的 Python 版本只有 `2.7.5`, 很多新鲜的包都不能正常使用,
一怒之下尝试更新其至目前最新的 `2.7.13` 版本, 顺便编译最新的 Python 3.6.2.
当然系统自带的 Python 2.7.5 是不能删除的, 会导致很多依赖它的工具无法正常工作,
所以将新版本的 Python 安装至 `/usr/local/` 下.

首先安装一些依赖, 比如

```bash
yum install openssl-devel
```

比如 `SQLite`:

```bash
wget http://www.sqlite.org/snapshot/sqlite-snapshot-201708251543.tar.gz
tar zxf sqlite-snapshot-201708251543.tar.gz
cd sqlite-snapshot-201708251543
./configure --prefix=/usr/local
```

下面开始 Python 的编译工作:

```
wget https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz
tar zxf Python-2.7.13.tgz
cd Python-2.7.13
./configure --prefix=/usr/local
make && make install
```

Python 3 的编译安装同理, 将网址改为
`https://www.python.org/ftp/python/3.6.2/Python-3.6.2.tgz` 即可.

这时会发现 `yum` 不能用了, 需要将 `/usr/bin/yum`,
`/usr/libexec/urlgrabber-ext-down` 的 `shebang` 改为 `/usr/bin/python2.7`,
也就是原来的低版本 (2.7.5).
