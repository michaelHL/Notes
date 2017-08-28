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

