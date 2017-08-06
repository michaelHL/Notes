## CentOS7.3(REHL 7)为 GDB 工具安装必要包 debuginfo

对简单的一段程序进行调试, 却提示缺少包, 需要通过 `debuginfo-install`
去安装 `glibc-2.17-...`, 但无法直接安装 `debuginfo-install`,
发现此工具在 `yum-utils` 中, 所以首先安装 `yum-utils`

```sh
yum install yum-utils
```

然后需要在 `/etc/yum/repos.d` 下新建 `CentOS-Debuginfo.repo` 文件:

```
#Debug Info
[debuginfo]
name=CentOS-$releasever - DebugInfo
baseurl=http://debuginfo.centos.org/$releasever/$basearch
gpgcheck=0
enabled=1
```

保存即可.

参考:

- [gdb调试时的问题Missing separate debuginfos, use: debuginfo-install glibc-XXX](http://blog.csdn.net/testcs_dn/article/details/19565411)
- [Missing separate debuginfos, use: debuginfo-install glibc-2.12-1.47.el6_2.9.i686 libgcc-4.4.6-3.el6.i686 libstdc++-4.4.6-3.el6.i686](https://stackoverflow.com/questions/10389988/missing-separate-debuginfos-use-debuginfo-install-glibc-2-12-1-47-el6-2-9-i686)
- [Available Repositories for CentOS](https://wiki.centos.org/AdditionalResources/Repositories)
