## ConEmu 折腾笔记

官网: [ConEmu][conemu]

- 首先设置为默认的系统终端程序, 替换掉残废的 `cmd`: `Integration`,
  `Default term`, `Force ConEmu as default terminal for console applications`
- 顺便在下面的对话框中填入 `explorer.exe|devenv.exe` 以被 VS 唤起
- 对于 `MSYS2` 的集成:
  1. 新建 `Task`: `set MSYSTEM=MINGW64 & "/path/to/MSYS-connector"`
  1. `Connector` 网址: [cygwin-connector][connector], 不同版本的设置如下:
     - `Cygwin`:   `conemu-cyg-32.exe` and `conemu-cyg-64.exe`
     - `MSYS 1.0`: `conemu-msys-32.exe`
     - `MSYS 2.0`: `conemu-msys2-32.exe` and `conemu-msys2-64.exe`

     复制到 `sh.exe` 同目录下即可
- 设置一波启动时设定 (`Startup`, `Environment`):
  ```
  set PATH=%ConEmuBaseDir%\Scripts;%PATH%
  chcp utf-8
  set LANG=en_US.utf-8
  ```
- 当前的配置文件 [conemu.xml](../src/conemu.xml)

[conemu]: https://conemu.github.io
[connector]: https://github.com/Maximus5/cygwin-connector
