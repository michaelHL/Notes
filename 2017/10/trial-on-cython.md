## 一次不太合适的 Cython 试验

一心想着用 [Cython][cython] 创建一个独立的可执行文件,
但其实它的初衷并不是像 C/C++ 一样编译成真正的机器码,
也就是说编译之后的文件还是需要基于 Python 才能运行的.

一段简单的 Fibnacci 程序:

```python
import time

def fib(n):
    if n == 0:
        return 0
    if n == 1:
        return 1
    return fib(n - 1) + fib(n - 2)
t = time.time()
print(fib(40))
print(time.time() - t)
```

于 `MinGW-w64` 下编译:

```sh
#!/bin/sh
export PYTHONHOME=/d/Anaconda3/envs/workspace
export PYTHONPATH=/d/Anaconda3/envs/workspace/Lib:/d/Anaconda3/envs/workspace/Lib/site-packages
/d/Anaconda3/envs/workspace/Scripts/cython --embed test.py
gcc -DMS_WIN646 -municode -mthreads -Wall -O \
-I/d/Anaconda3/envs/workspace/include \
-L/d/Anaconda3/envs/workspace/libs \
test.c -lpython36 -o test.exe
echo "python:"
python3 test.py
echo "cython:"
./test.exe
```

这仅是初级玩法, 以后慢慢深入.

### 参考

- [Compiling Python 3.5 code with Cython and MinGW on Windows 7 (64bit)](https://stackoverflow.com/questions/34894094/compiling-python-3-5-code-with-cython-and-mingw-on-windows-7-64bit)
- [Building standalone application with Cython + MinGW](https://stackoverflow.com/questions/24219012/building-standalone-application-with-cython-mingw)
- [用Cython加速Python程序](http://www.cnblogs.com/yafengabc/p/6130849.html)
- [ImportError: No module named 'encodings'](https://stackoverflow.com/questions/38132755/importerror-no-module-named-encodings)

[cython]: http://cython.org/
