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
1. Install the CentOS 6 GCC packages. This will ask you if you want to
   install around 11 packages, due to dependencies.
   ```
   yum install gcc gcc-c++
   ```
1. Check the installed versions, and show their locations.
   ```
   gcc --version
       May say: gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-11)
   g++ --version
       May say: g++ (GCC) 4.4.7 20120313 (Red Hat 4.4.7-11)
   which gcc
       /usr/bin/gcc
   which g++
       /usr/bin/g++
   ```

### Install a newer version of GCC from source

If you only want the CentOS officially supported version of GCC,
you're all set. If you need a more recent version of GCC, continue on.

1. **IMPORTANT!** First, complete the steps above to install an older binary version of GCC.
1. Install additionally required packages. This will ask you if you want to install around 41 packages.
   ```
   yum install svn texinfo-tex flex zip libgcc.i686 glibc-devel.i686
   ```
1. Decide which version of GCC you want to install. This command will show you the "tags" for each of the versions available.
   ```
   svn ls svn://gcc.gnu.org/svn/gcc/tags | grep gcc | grep release
       gcc-2_95-release/
       ...
       gcc-4_9_2_release/
       gcc-5_1_0_release/
   ```
1. Get the source of the version of GCC you want. This will run for a few minutes.
   The rest of this article is written for `gcc-5_1_0_release` and will
   download the sources into `~/sourceInstallations/gcc_5_1_0_release/`.
   ```
   mkdir ~/sourceInstallations
   cd ~/sourceInstallations
   svn co svn://gcc.gnu.org/svn/gcc/tags/gcc_5_1_0_release/
   ```
1. Get the source of additional prerequisites.
   Using v5.1.0, this downloads sources and adds them to the GCC build
   for MPFR v2.4.2, GMP 4.3.2, and MPC 0.8.1.
   ```
   cd gcc_5_1_0_release/
   ./contrib/download_prerequisites
       --- Important, run this as shown, from the gcc_5_1_0_release directory.
       ---   Do not cd to the contrib directory
   ```
1. If your VPS only has 768MB of memory,
   you will run out of memory in the next step. If you have 1GB of memory,
   you may be OK, but it can't hurt to do this step.
   If you have 2GB of memory, or more, you can skip this step.
   This step adds 500MB of virtual memory, using a swap file.
   ```
   SWAP=/tmp/swap
   dd if=/dev/zero of=$SWAP bs=1M count=500
   mkswap $SWAP
   swapon $SWAP
   ```
1. Build GCC. This will run for hours. If this completes correctly,
   the last line you will see will say "success".
   It is normal to see some error-looking messages scrolling by quickly,
   as long as the build completes and echos "success".
   It's always a good idea to build things in a different directory than a
   source directory. GCC documentation states that you should not use a
   build directory that is a sub-directory of the source directory.
   ```
   cd ..
   mkdir gcc_5_1_0_release_build/
   cd gcc_5_1_0_release_build/
   ../gcc_5_1_0_release/configure && make && make install && echo "success"
   --- If your VPS has multiple cores, you can speed up the build by changing the middle part
   ---   of this line from "&& make &&" to "&& make -j <number of cores> &&".
   --- You can see the number of cores your VPS has by running "nproc"
   ```
1. If you set up a swap file in step 6, remove it.
   Without doing more configuring, after a reboot,
   it won't be used as a swap file,
   and just take up hard drive space in your VPS.
   ```
   swapoff $SWAP
   rm /tmp/swap
   ```
1. Check the installed versions, and see their locations.
   ```
   hash -r
       (Makes your login "forget" about the previously seen locations of gcc and g++)
   gcc --version
       May say: gcc (GCC) 5.1.0
   g++ --version
       May say: g++ (GCC) 5.1.0
   which gcc
       /usr/local/bin/gcc
   which g++
       /usr/local/bin/g++
   ```
1. Add the new libraries to ld (the GNU linker).
   ```
   echo "/usr/local/lib64" > usrLocalLib64.conf
   sudo mv usrLocalLib64.conf /etc/ld.so.conf.d/
   sudo ldconfig
       --- This may say a file or two "is not an ELF file - it has the wrong magic bytes at the start."
       --- You may ignore this message.  It is silent about the work it successfully completed.
   ```
1. Optionally make a hello world program.
   ```
   mkdir ~/code
   cd ~/code
   Create a file main.cpp that says:
       #include <iostream>
       using namespace std;
       int main() {
           cout << "Hello world!" << endl;
           return 0;
       }
   --- One way to create this file is to run "vi main.cpp", hitting "i" to enter insert mode,
   ---   typing the above file, hitting ESC, and hitting "ZZ" to save.
   g++ main.cpp -o main
   ./main
       Hello World!
   ```
1. Optionally reclaim hard drive space. Your `~/sourceInstallations`
   folder will be taking up around 8.0GB. It's probably wise to keep the folders,
  as there are optional configuration options you may need to use at some
  point in the future, and it would be faster to have a lot already done.
  Also, the build process makes logs that you can later check and work
  from if something goes wrong. But, after running `sudo make install` earlier,
  your installed GCC isn't depending on anything in this directory,
  and space can be at a premium, so you can do this step and reclaim
  the 8.0GB or so.
  ```
  cd ~/
  rm -rf sourceInstallations
  --- Again, if you can spare the space, you may someday be happy to have left it there.
  ```

You now have your CentOS officially supported `gcc` and `g++` still in
`/usr/bin/`, your CentOS officially supported 32-bit libs in `/lib`,
your CentOS officially supported 64-bit libs in `/lib64`,
and your CentOS officially supported include files in `/usr/include`.

Your newer gcc and `g+`+ are in `/usr/local/bi`n,
newer 32-bit libs in `/usr/local/lib`,
your newer 64-bit libs in `/usr/local/lib64`,
and your newer include files in `/usr/local/include`.


[link]: https://www.vultr.com/docs/how-to-install-gcc-on-centos-6
