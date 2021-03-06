## Windows 相关

1. JetBrains 的 `vim` 插件配置文件放在 `~/.ideavimrc`
1. MS Acces 自动切换输入法修复方法:
   Options -> Client Settings -> Datasheet IME control
1. 恶心的 `Connected User Experiences and Telemetry`:
    1. 打开计划任务程序, 定位到 Microsoft-Windows-Application Experience,
        禁用 Microsoft Compatibility Appraiser
    2. 打开服务, 禁用 Connected User Experiences and Telemetry
    3. 以上步骤适用于 1607 版
1. 卸载 OneDrive:
    1. 不让 OneDrive 弹出: <kbd>win</kbd><kbd>x</kbd><kbd>a</kbd>
       -> `taskkill /f /im OneDrive.exe`
    2. `%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall` (注意系统位)
1. MobaXterm 中设置 Cygwin 的源
    - `apt-cyg -m http://mirrors.neusoft.edu.cn/cygwin/ install/remove. ...`
    - `apt-cyg -m http://mirrors.ustc.edu.cn/cygwin/ install/remove ...`
    - `apt-cyg -m http://mirrors.aliyun.com/cygwin/ install/remove ...`
    - `apt-cyg -m http://mirrors.163.com/cygwin/ install/remove ...`
1. MobaXterm 中的 Cygwin 如有命令出错, 有可能是版本过低
1. MobaXterm 中如果无法安装包(一般出现校验值错误的情况), 可手动下载 `setup.ini`,
   注意版本为 `x86`
1. Sublime Text 插件 SFTP 注册码: (在 `Settings-User` 中加入)
    ```json
    {
        "email":"Rimke@163.com",
        "product_key":"e83eda-38644b-43c828-e3669b-cd8a85",
    }
    ```
1. Sublime Text 插件 AStyleFormatter 报错:
   安装 Microsoft Visual C++ 2010 SP1 Redistributable Package (x64)
1. Sublime Text 主题插件 Boxy 深度定制:
    - `Boxy` 侧边栏背景色: `Sidebar Tree Defaults - "sidebar_tree"`
    - `Boxy` 侧边栏分隔: `"class": sidebar_container", "layer0.tint"`
1. Potplayer 遇到「单声道」的情况, 将声音 - 环绕置 0 即可
1. 任务栏透明: [StartIsBack](http://www.zdfans.com/5573.html)
1. win 7 下一些控件、动态链接库无法注册问题的终极解决办法(**不推荐**):
   激活并登陆 `Administrator` 账户 (一定必须为该名称,
   即使为管理员账户也不能行使此账户的一些职权)
1. 清除各种显卡右键菜单:
    - Nvidia:
      - 清除: `regsvr32 /u nvcpl.dll`
      - 显示: `regsvr32 nvcpl.dll`
    - Intel:
      - 清除: `regsvr32 /u igfxsrvc.dll`
      - 显示: `regsvr32 igfxsrvc.dll`
    - Ati:
      - 清除: `regsvr32 /u atiacmxx.dll`
      - 显示: `regsvr32 atiacmxx.dll`
    - Intel集成:
      - 清除: `regsvr32 /u igfxpph.dll`
      - 显示: `regsvr32 igfxpph.dll`
1. 修复 vbs 默认打开方式: `cmd /c cscript/h:wscript`
1. 无法附着到任务栏:
   ```
   cmd /k reg add "HKEY_CLASSES_ROOT\lnkfile" /v IsShortcut /f
   cmd /k reg add "HKEY_CLASSES_ROOT\piffile" /v IsShortcut /f
   cmd /k taskkill /f /im explorer.exe & explorer.exe
   ```
1. 启动项文件夹: `shell:Startup`
1. Cygwin 中 Mintty 快捷方式: `mintty.exe -i /Cygwin-Terminal.ico -`
1. npm 路径: `C:\Users\xxx\AppData\Roaming\npm`
1. tlmgr 更换 repository:
   ```
   tlmgr option repository http://mirrors.aliyun.com/CTAN/systems/texlive/tlnet
   tlmgr option repository http://mirrors.ustc.edu.cn/CTAN/systems/texlive/tlnet
   ```
   CLI 下更新:
   ```
   tlmgr update --self --repository http://mirrors.aliyun.com/CTAN/systems/texlive/tlnet/
   tlmgr update --all --repository http://mirrors.aliyun.com/CTAN/systems/texlive/tlnet/
   ```
1. Sublime Text 插件 SublimeREPL 出现
   `OSError: [WinError 6] The handle is invalid` 解决方案:
   `Data/Packages/SublimeREPL/repls/subprocess_repl.py`
   ```
   def is_alive(self):
       return True
   ```
1. Sublime Text 开启 Debug 模式: `sublime.log_commands(True)`
1. 华丽的提示符: 添加环境变量 `PROMPT`,
   比如 `[ Nasty-Newbie $b $t $b $p ]$_$$ `,
   显示成:
   ```
   [ Nasty-Newbie | 12:26:26.91 | C:\Users\Michael ]
   ```
1. `MSYS2` 中自动挂载文件: `/etc/fstab`, 比如:
   ```
   # For a description of the file format, see the Users Guide
   # http://cygwin.com/cygwin-ug-net/using.html#mount-table

   # DO NOT REMOVE NEXT LINE. It remove cygdrive prefix from path
   none / cygdrive binary,posix=0,noacl,user 0 0
   C:\Users\Michael\Desktop /desktop
   D:\MSYS2\home\Michael\Notes /notes
   F:\WorkingDirectory\Work\__current /current
   ```
1. Chrome 浏览器在高分屏幕下的快捷方式:
   ```
   "\chrome.exe" /high-dpi-support=1 /force-device-scale-factor=1
   ```
1. 为 [SourceForge](https://sourceforge.net) 加速:
   http://sourceforge.mirrorservice.org
1. Sublime Text 插件 LaTeXTools 关于 PDF 阅读器 SumaptraPDF 反向搜索的设置:
   ```
   sumatrapdf.exe -inverse-search "\"C:\Program Files\Sublime Text 3\sublime_text.exe\" \"%f:%l\""
   ```
   关于公式不能预览的问题: 手动从 [Ghostscript 官网](https://ghostscript.com)
   安装, 并将环境路径添加至 `TexLive` 路径前面; 添加 ImageMagick 的环境路径
1. Mathtype 的官方安装包名为 `InstallMTW6.9b.exe`
1. Avast 杀毒软件的安装需要取消勾选 `Real Site` (中文名可能为 `DNS` 相关),
   否则网速奇慢! 顺便, 防火墙也别装了, 简直神坑!
1. Avast 添加排除目录 (添加信任): `Settings` -> `Components` ->
   `File Shield` && `Behavior Shield` -> `Customize` -> `Exclusions`,
   否则某些程序会无端卡死 (比如赖以生存的 `ConEmu`)
1. 用 UltraISO 刻录的 Windows 10 系统 U 盘无法创建分区 (提示为 MBR / GPT
   分区) 解决方案: 删除 U 盘中文件夹 `efi/` 以及文件 `bootmgr.efi`
1. TeamViewer(TV) 提示
   > The screen cannot be captured at the moment.
   > This is probably due to fast user switching or a disconnected/minimized
   > Remote Desktop session.

   且场景为: 被连接的机器为笔记本, 盒上盖子, 已打开 tv 服务.  
   解决方案:
   - 打开笔记本盖子
   - 或将一根 HDMI 线连接至显示器
1. Sublime Text 插件 Anaconda 显示类似如下错误且伴有切换至 `python` 文件卡顿:
   ```
   <Anaconda.anaconda_lib.workers.local_worker.LocalWorker object at 0x000001EA4B464FD0> initial check failed because:  
   connection to localhost:51568 timed out after 0.2s. tried to connect 7 times during 2 seconds  
   check that there is Python process executing the anaconda jsonserver.py script running in your system. If there is, check that you can connect to your localhost writing the following script in your Sublime Text 3 console:  
   import socket; socket.socket(socket.AF_INET, socket.SOCK_STREAM).connect(("localhost", 51568))
   ```
   场景: MSYS2 环境变量 `/usr/bin`, `/mingw64/bin`; Anaconda 没有加入环境变量.  
   解决方案: 将 `"python_interpreter": "/path/to/python_exe"`
   加入**用户配置文件** `Preferences.sublime-settings`
1. Xshell 5 中 <kbd>shift</kbd><kbd>tab</kbd> 效果却为切换标签处理办法:
   设置一次针对 <kbd>shift</kbd><kbd>tab</kbd> 的快捷键, 再取消设置这个快捷键
1. Word 里面用 Mathtype 编辑的公式用默认的方法导出 PDF 文件时出现各类显示问题:
   改用 [doPDF](http://www.dopdf.com)
1. Sublime Text 插件 Clang Format 令其对全文件格式化:
   [Format whole file if nothing selected](https://github.com/rosshemsley/SublimeClangFormat/pull/10/commits/ea22686f40009104935a0378b7c4fd387121c8a1)
1. Sublime Text 插件 LaTeXTools 中公式渲染/预览不全解决方案:  
   配置文件中为 `preview_math_template_preamble` 添加
   `\usepackage[margin=2cm]{geometry}`
1. Windows 批处理在后台运行程序: `start /b xxx`,
   输出会在当前窗口 (当然可以通过 `>nul 2>&1` 抑制输出),
   但是可以进行其他操作 (有点类似于 *nix 中的 `&`).
   或者 `start /min "" program params`,
   会在最小化的新窗口中运行程序, 同时控制权交给当前终端
1. Potplayer 关闭左上角的进度显示: 基本 -> 消息 -> 取消勾选「在屏幕上显示播放信息」
1. 自动锁屏可在屏幕保护程序中进行设置, 即便是空的锁屏样式
1. MSYS2 中安装 `watch`: `pacman -S procps-ng`
1. GNU 工具源码镜像: http://mirrors.ustc.edu.cn/gnu
1. Ghost 系统桌面出现顽固图标注册表:
   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace`
1. 列出所有 Windows 服务状态: `sc queryex type= service state= all | find /i "NATION"`
