## Windows 相关

1. [JetBrains, ideavim] `vim` 配置文件放在 `~/.ideavimrc`
1. [Office, Acces] 自动切换输入法修复方法:
   Options -> Client Settings -> Datasheet IME control
1. [OS]
    1. 打开计划任务程序, 定位到 Microsoft-Windows-Application Experience,
        禁用 Microsoft Compatibility Appraiser
    2. 打开服务, 禁用 Connected User Experiences and Telemetry
    3. 以上步骤适用于 1607 版
1. [OS, OneDrive]
    1. 不让 OneDrive 弹出: <kbd>win</kbd><kbd>x</kbd><kbd>a</kbd>
       -> `taskkill /f /im OneDrive.exe`
    2. `%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall` (注意系统位)
1. [Moba, Cygwin, mirror]
    - `apt-cyg -m http://mirrors.neusoft.edu.cn/cygwin/ install/remove. ...`
    - `apt-cyg -m http://mirrors.ustc.edu.cn/cygwin/ install/remove ...`
    - `apt-cyg -m http://mirrors.aliyun.com/cygwin/ install/remove ...`
    - `apt-cyg -m http://mirrors.163.com/cygwin/ install/remove ...`
1. [Moba, Cygwin] 如果有命令出错, 有可能是版本过低.
1. [Sublime Text, SFTP] SFTP 注册码: (在 `Settings-User` 中加入)
    ```json
    {
        "email":"Rimke@163.com",
        "product_key":"e83eda-38644b-43c828-e3669b-cd8a85",
    }
    ```
1. [Sublime Text, SublimeAStyleFormatter] AStyleFormatter报错:
   安装 Microsoft Visual C++ 2010 SP1 Redistributable Package (x64)
1. [Sublime Text, Boxy]
    - `Boxy` 侧边栏背景色: `Sidebar Tree Defaults - "sidebar_tree"`
    - `Boxy` 侧边栏分隔: `"class": sidebar_container", "layer0.tint"`
1. [Potplayer] 遇到「单声道」的情况, 将声音 - 环绕置 0 即可
1. [美化] 任务栏透明: [StartIsBack](http://www.zdfans.com/5573.html)
1. win 7 下一些控件、动态链接库无法注册问题的终极解决办法(**不推荐**):
   激活并登陆 `Administrator` 账户 (一定必须为该名称,
   即使为管理员账户也不能行使此账户的一些职权)
1. 清除各种显卡右键菜单:
    - Nvidia:
          清除: `regsvr32 /u nvcpl.dll`
          显示: `regsvr32 nvcpl.dll`
    - Intel:
          清除: `regsvr32 /u igfxsrvc.dll`
          显示: `regsvr32 igfxsrvc.dll`
    - Ati:
          清除: `regsvr32 /u atiacmxx.dll`
          显示: `regsvr32 atiacmxx.dll`
    - Intel集成:
          清除: `regsvr32 /u igfxpph.dll`
          显示: `regsvr32 igfxpph.dll`
1. 修复 vbs 默认打开方式: `cmd /c cscript/h:wscript`
1. 无法附着到任务栏：
    ```
    cmd /k reg add "HKEY_CLASSES_ROOT\lnkfile" /v IsShortcut /f
    cmd /k reg add "HKEY_CLASSES_ROOT\piffile" /v IsShortcut /f
    cmd /k taskkill /f /im explorer.exe & explorer.exe
    ```
1. 启动项文件夹: shell:Startup
1. Cygwin 中 Mintty 快捷方式: `mintty.exe -i /Cygwin-Terminal.ico -`
1. npm 路径: `C:\Users\xxx\AppData\Roaming\npm`
1. tlmgr 更换 repository:
   ```
   tlmgr option repository http://mirrors.aliyun.com/CTAN/systems/texlive/tlnet
   ```
