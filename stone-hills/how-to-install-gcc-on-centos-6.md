## CentOS 系统安装 GCC

> 链接: [How To Install GCC on CentOS 6][link]  
> 日期: Published on: Tue, Apr 28, 2015 at 1:02 am EST

CentOS follows the development of Red Hat Enterprise Linux (RHEL).
RHEL strives to be a stable server platform, which means that it does not rush
to include the latest versions of every software package.

As of the writing of this article, CentOS 6 officially distributes GCC v4.4.7.
However, GCC v5.1 was recently released. Before that, v4.9.2 was available.

The official suggestion to needing a more recent version of GCC is that you
should consider a different UNIX distribution which is more focused on
supporting the latest versions of software packages.

Fortunately, you are able to install a more recent version of GCC on CentOS,
leaving the older version still installed. This deviates from purely using
the officially distributed software, but sometimes you may feel like you have
little choice. You can run into some complications; for example,
if you are installing third party kernel modules, they must be compiled
using the same version of GCC used to build your kernel.

This article describes how to install the CentOS 6 officially supported
version of GCC, and how to install a newer version as well.
This article assumes that you have a freshly installed CentOS 6 VPS,
although you can certainly follow the instructions on an existing VPS.

### Install an officially supported (older) version of GCC

Even if you want to install a newer version of GCC from source,
GCC itself is written in C++.
Therefore, you first have to install an older C++ compiler.

1. Login to your VPS, either by clicking "View Console" in the Vultr control
   panel, or by SSH, if you have set that up.
   1. Login as root.
   1. Create your own user account, and give it a password.
      ```
      adduser <username>
      passwd <username>
      ```
   1. Allow your user account to execute commands with root privileges,
      through the sudo command.
      ```
      visudo
          After the line "root   ALL=(ALL)   ALL"
          Add the line "<username>   ALL=(ALL)   ALL"
          --- If you aren't familiar with vi, go to the line "root   ALL=(ALL)   ALL".
          ---   Hit "o" to create a new line after that line and enter insert mode.
          ---   Type "<username>   ALL=(ALL)   ALL".
          ---   Hit ESC.
          ---   Type "ZZ" to save.
      ```
   1. Log out as root, and login to your user account.


[link]: https://www.vultr.com/docs/how-to-install-gcc-on-centos-6
