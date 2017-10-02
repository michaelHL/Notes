## CentOS 系统安装 LLVM 以及 Clang

> 链接: [How To Install LLVM and Clang on CentOS 6][link]  
> 日期: Wed, May 13, 2015 at 3:22 am EST

LLVM is an open-source compiler infrastructure. LLVM was started in 2000,
and has been extensively used and modified by Apple since 2005. Clang is a C,
C++, Objective-C, and Objective-C++ compiler that works with the LLVM system.
Clang was started in 2007 by Apple, and since then Google and Intel have
become involved in its continued development.

Clang's developers claim that compared to GCC, it compiles faster,
uses less memory, gives more user friendly diagnostics during compilation,
and is compatible with GCC.

CentOS follows the development of Red Hat Enterprise Linux (RHEL).
RHEL strives to be a stable server platform, which means it does not rush to
include the latest versions of everything.

As of the writing of this article, CentOS 6 officially distributes
LLVM & Clang v3.4.2. However, Clang v3.6 has been released.

The official suggestion is if you need a more recent version of LLVM & Clang,
you should consider a different UNIX distribution which is more focused on
supporting the latest versions of software packages.

Fortunately, you are able to install a more recent version LLVM & Clang GCC
on CentOS. This deviates from purely using the officially distributed software,
but sometimes you may feel like you have little choice.

This article describes how to install the CentOS 6 officially supported
version of LLVM & Clang, and how to install a newer version.
This article assumes you have a freshly installed CentOS 6 VPS,
however you can certainly follow the instructions on a VPS you have already
been using.

Clang is largely independent from GCC, but as of the writing of this article,
Clang still uses several shared libraries installed by GCC (namely,
`crtbegin.o`, `gcc`, and `gcc_s`). If you install LLVM & Clang on CentOS 6,
you won't be able to compile anything if you don't also have GCC on your
system for these shared libraries. Ideally, yum would have a package
dependency for clang of gcc and gcc-c++, but as of the writing of this article,
yum is unaware of the dependency.

Additionally, building a newer version of LLVM & Clang from source requires
G++ v4.7+, which you can only get on CentOS 6 by installing it by source.

If you run all of the steps below, you'll wind up with 2 versions of GCC and 2
versions of LLVM & Clang. This includes an officially supported binary older
version and a newer version from source for each program. However,
there's no need to run all the steps below. You can decide whether you want
the officially supported binary older version of LLVM & Clang,
or the newer version from source, and run whichever section of instructions
fits your decision.

### Install an officially supported (older) version of LLVM & Clang

1. **IMPORTANT!** First, install an officially supported (older) version of GCC,
   by performing the steps in the article [How to Install GCC on CentOS 6](how-to-install-gcc-on-centos-6.md)
   -- you do NOT need to perform the steps under that article's heading
   "Install a newer version of GCC from source".
1. Install LLVM & Clang
   ```
   sudo yum install clang
    --- This will bring in llvm as a dependency
   ```
1. Check the installed versions, and see their locations.
   ```
   clang --version
       May say: clang version 3.4.2 (tags/RELEASE_34/dot2-final)
   which clang
       /usr/bin/clang
   gcc --version
       May say: gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-11)
   g++ --version
       May say: g++ (GCC) 4.4.7 20120313 (Red Hat 4.4.7-11)
   which gcc
       /usr/bin/gcc
   which g++
       /usr/bin/g++
   ```

### Install a newer version of LLVM & Clang from source

To build LLVM & Clang by source on CentOS, you have to have GCC v4.7 or above.
CentOS 6 does not have this high of a version in yum,
so you first have to install a more recent GCC from source.

1. **IMPORTANT!** First, install a newer version of GCC from source,
   by performing the steps in the article [How to Install GCC on CentOS 6](how-to-install-gcc-on-centos-6.md)
   -- you DO need to perform all steps in that article,
   including under the heading "Install a newer version of GCC from source".
1. Install additionally required packages.
   ```bash
   yum install cmake
   ```
1. Install a newer version of Python. LLVM & Clang v3.6.0 requires Python v2.7+,
   but CentOS 6 yum repository only has Python v2.6.6.
   ```
   mkdir ~/sourceInstallations
   cd ~/sourceInstallations
   wget https://www.python.org/ftp/python/2.7.9/Python-2.7.9.tgz
   tar -xvf Python-2.7.9.tgz
   cd Python-2.7.9
   ./configure && make && sudo make install
   ```
1. Decide which version of LLVM & Clang you want.
   This command will show you the "tags" for the versions available.
   ```
   svn ls http://llvm.org/svn/llvm-project/llvm/tags | grep RELEASE
       RELEASE_1/
       ...
       RELEASE_352/
       RELEASE_360/
       RELEASE_361/
   svn ls http://llvm.org/svn/llvm-project/llvm/tags/RELEASE_361
       rc1/
       --- At this time, there is no final, just a release candidate.  You could certainly use a release candidate, but this article will show how to use a final release.
   svn ls http://llvm.org/svn/llvm-project/llvm/tags/RELEASE_360
       final/
       rc1/
       rc2/
       rc3/
       rc4/
   ```
1. Get the source of the version of LLVM & Clang that you want.
   This will run for a few minutes. The rest of this article is written for
   `RELEASE_360/` and will download the sources into `~/sourceInstallations/llvm_RELEASE_360/`
   -- You will have to substitute the proper tag to fit future versions.
   The directories below of `compiler-rt`, `libcxx`, and `libcxxabi`
   are not absolutely necessary, but contain some of the features that
   LLVM & Clang have that GCC doesn't, so are included in this article.
   There are other LLVM "sub-projects" you could choose to use,
   such as dragonegg, LLDB, OpenMB, vmkit, polly, libclc, klee, SAFECode,
   and lld. You can read about those on the [LLVM website][LLVM].
   ```
   cd ~/sourceInstallations
   svn co http://llvm.org/svn/llvm-project/llvm/tags/RELEASE_360/final llvm_RELEASE_360
   cd llvm_RELEASE_360/tools
   svn co http://llvm.org/svn/llvm-project/cfe/tags/RELEASE_360/final clang
   cd ../projects
   svn co http://llvm.org/svn/llvm-project/compiler-rt/tags/RELEASE_360/final compiler-rt
   svn co http://llvm.org/svn/llvm-project/libcxx/tags/RELEASE_360/final libcxx
   svn co http://llvm.org/svn/llvm-project/libcxxabi/tags/RELEASE_360/final libcxxabi
   cd ..
   svn update
       At revision X.
       --- Hopefully this outputs one line saying "At revision X", but numbers instead of "X".  If it downloads more source files, a new revision was released while you were downloading the source code.  This is highly unlikely unless you're using trunk (the most up to date, maybe unstable code.)  But, if this happens, perform a svn update in the tools/clang, projects/compiler-rt, projects/libcxx, projects/libcxxabi, and again ~/sourceInstallations/llvm_RELEASE_360, until you are fully up to date.
   ```
1. Build LLVM & Clang. This will run for a while. If this completes correctly,
   the last line you will see will say "success".
   It is normal to see some error-looking messages scrolling by quickly.
   It's always a good idea to build things in a different directory than a
   source directory.
   ```
   mkdir ../llvm_RELEASE_360_build
   cd ../llvm_RELEASE_360_build
   cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=/usr/local/bin/gcc -DCMAKE_CXX_COMPILER=/usr/local/bin/g++ ../llvm_RELEASE_360 && make && sudo make install && echo success
       --- If your VPS has multiple cores, you can speed up the build by changing the middle part
       ---   of this line from "&& make &&" to "&& make -j <number of cores> &&".
       --- You can see the number of cores your VPS has by running "nproc"
       --- If you omit -DCMAKE_BUILD_TYPE=Release, the build defaults to debug.  This is great if you need to debug LLVM & Clang itself, but slows down compilation of your end programs considerably.
       --- If you omit the references to gcc and g++, it will default to using the older binary versions in /usr/bin/, and will not compile.
   ```
1. Check the installed versions, and see their locations.
   ```
   clang --version
       May say: clang version 3.6.0 (tags/RELEASE_360/final 237229)
   clang++ --version
       May say: clang version 3.6.0 (tags/RELEASE_360/final 237229)
   which clang
       /usr/local/bin/clang
   which clang++
       /usr/local/bin/clang++
   ```
1. Add the new libraries to ld (the GNU linker).
   ```
   echo "/usr/local/lib" > usrLocalLib.conf
   sudo mv usrLocalLib.conf /etc/ld.so.conf.d/
   sudo ldconfig
       --- This may say a file or two "is not an ELF file - it has the wrong magic bytes at the start."
       --- You may ignore this message.  It is silent about the work it successfully completed.
   ```
1. Optionally make a "hello world" program.
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
   clang++ main.cpp -o main
   ./main
       Hello World!
   clang++ -stdlib=libc++ -lc++abi main.cpp -o main
       --- This uses Clang's libc++ and libc++abi, instead of the GNU stdlibc++ and stdlibc++abi
   ./main
       Hello world!
   ```
1. Use LLVM & Clang when you want to.
   ```
   You could set LLVM & Clang to be your system's default C and C++ compiler by running:
       echo "export CC=/usr/local/bin/gcc" >> ~/.bashrc
       echo "export CXX=/usr/local/bin/g++" >> ~/.bashrc
       source ~/.bashrc
   Once and a while there is a difference between Clang and GCC, but it's becoming more and more rare.  To be more conservative, you could specify in your code's buildsystem to use LLVM & Clang, but otherwise leave your system's default to the source build of GCC.
   ```
1. Optionally reclaim hard drive space. Your `~/sourceInstallations` folder
   will be taking up around 11GB of disk space. It's probably wise to keep the
   folders, as there are optional configuration options you may need to use
   at some point in the future, and it would be faster to have
   a lot already done. And, as mentioned above, there are additional
   "sub-projects" you can add to LLVM & Clang. Also, the build
   process makes logs that you can later check and work from if something
   goes wrong. But, after running "sudo make install" earlier,
   your installed LLVM & Clang isn't depending on anything in this directory,
   and space can be at a premium, so you can do this step and reclaim the 11GB.
   ```
   cd ~/
   rm -rf sourceInstallations
   --- Again, if you can spare the space, you may someday be happy to have left it there.
   ```

You now have your newer LLVM & Clang in `/usr/local/bin`,
your newer 64-bit LLVM & Clang libs in `/usr/local/lib`,
and your newer LLVM & Clang include files in `/usr/local/include`.


[link]: https://www.vultr.com/docs/how-to-install-llvm-and-clang-on-centos-6
[LLVM]: http://llvm.org/
