## ConEmu 折腾笔记

官网: [ConEmu][conemu]

- 首先设置为默认的系统终端程序, 替换掉残废的 `cmd`: `Integration`,
  `Default term`, `Force ConEmu as default terminal for console applications`
- 顺便在下面的对话框中填入 `explorer.exe|devenv.exe` 以被 VS 唤起
- 对于 `MSYS2` 的集成:
  1. 新建 `Task`: `set MSYSTEM=MINGW64 & "/path/to/MSYS-connector -cur_console:n"`
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

### 问题

#### 对于 Sublime Text 的集成

对于一般程序, 在设置中的 `Integration` -> `Default term` -> `List of ...`
中添加程序, 如果这些程序调用 `cmd`, `conemu` 将会自动被调用, 但 `sublime_text.exe`
并没有反应, 只能曲线救国, 比如 C 类型文件的编译配置文件 `C.sublime-build`:

```
{
    // "shell_cmd": "gcc -std=c11 -Wall -s \"${file}\" -o \"${file_path}/${file_base_name}\" && \"${file_path}/${file_base_name}\"",
    "shell_cmd": "D:\\UtilityPrograms\\ConEmu\\ConEmu.exe /single -run cmd /c -cur_console:n \"gcc -std=c11 -Wall -s ${file} -o ${file_path}/${file_base_name} && ${file_path}/${file_base_name} & pause \"",
    "file_regex": "^(..[^:]*):([0-9]+):?([0-9]+)?:? (.*)$",
    "working_dir": "${file_path}",
    "selector": "source.c"
}
```

#### Zsh

折腾了几次 Zsh, 无论是 `mintty` 还是 `ConEmu`, 效果均不理想.
在 MSYS 中的修改方法不太清真, 需要修改启动的 `bat`,
而在 `ConEmu` 方便许多, 比如添加 `task`:

```
set CHERE_INVOKING=1 & set MSYSTEM=MINGW64 & /path/to/zsh.exe --login -i -cur_console:n
```

但上述方法不像之前通过 `connector` 连接, 打开 `vim` 的时候颜色会错乱,
加之 Zsh 在 MSYS 上反应略顿, 不折腾也罢!

HAPPY CODING! :satisfied:

[conemu]: https://conemu.github.io
[connector]: https://github.com/Maximus5/cygwin-connector
