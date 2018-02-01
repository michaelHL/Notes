## Linux 技巧拾零

1. 使对补全大小写不敏感.  
   所有用户: `/etc/inputrc`  
   当前用户: `~/.inputrc`  
   输入内容: `set completion-ignore-case on`
1. `history`不显示连续、重复、特定的命令、加上时间戳.  
   于`/etc/bashrc`(或`~/.bashrc`)中添加
   ```bash
   HISTTIMEFORMAT='%F %T '
   HISTCONTROL=erasedups
   HISTIGNORE="ls:pwd:cd:clear:vim:fg:bg:jobs:top"
   ```
   将`HISTCONTROL`设成`ignoredups`仅忽略连续的重复命令,
   而`erasedups`清除整个历史中重复条目.
1. 常用终端快捷键

   | 快捷键                       | 用途               | 快捷键                       | 用途                  |
   | :---                         | :---               | :---                         | :---                   |
   | <kbd>ctrl</kbd> <kbd>a</kbd> | 移动到行首         | <kbd>esc</kbd>  <kbd>f</kbd> | 移动到后面一个单词     |
   | <kbd>ctrl</kbd> <kbd>e</kbd> | 移动到行末         | <kbd>ctrl</kbd> <kbd>k</kbd> | 删除到行末             |
   | <kbd>ctrl</kbd> <kbd>b</kbd> | 移动到前面一个字母 | <kbd>ctrl</kbd> <kbd>u</kbd> | 删除到行首             |
   | <kbd>ctrl</kbd> <kbd>f</kbd> | 移动到后面一个字母 | <kbd>ctrl</kbd> <kbd>t</kbd> | 交换光标位置前两个字符 |
   | <kbd>esc</kbd>  <kbd>b</kbd> | 移动到前面一个单词 | <kbd>esc</kbd>  <kbd>t</kbd> | 交换光标位置前两个单词 |
1. SSH 登录服务器缓慢解决方案:
   - 关闭 DNS 反向解析: `vim /etc/ssh/sshd_config`,
     设定其中 `UseDNS=no`, 重启服务 `service sshd restart`
   - 服务端禁用 `GSSAPIAuthentication`: 同样在 `/etc/ssh/sshd_config`
     中设定  `GSSAPIAuthentication no`
1. SSH 登录欢迎界面设置文件: `/etc/motd`
1. SSH Log 日志文件:
   - `Redhat`, `Fedora Core`: `/var/log/secure`
   - `Mandrake`, `FreeBSD`, `OpenBSD`, `Debian`: `/var/log/auth.log`
   - `SUSE`: `/var/log/messages`
1. 系统内建函数 `time` **功能有限** (`real` 时间是指挂钟时间,
   也就是命令开始执行到结束的时间. 这个短时间包括其他进程所占用的时间片,
   和进程被阻塞时所花费的时间. `user` 时间是指进程花费在用户模式中的CPU时间,
   这是唯一真正用于执行进程所花费的时间, 其他进程和花费阻塞状态中的时间没有计算在内.
   `sys` 时间是指花费在内核模式中的 CPU 时间, 代表在内核中执系统调用所花费的时间,
   这也是真正由进程使用的 CPU 时间)  
   REHL 与 Debian 中的 `man time` 是不同的, 具体关于 `time` 的手册见
   [`TIME(1)`](src/man/TIME(1))  
   比如输出带管道命令的运行时间:
   `\time -f '%es' bash -c './test.py | sort > /dev/null'`,
   其中 `time` 前面的 `\` 消除 `alias` 对命令的影响 (相当于执行 `/usr/bin/time`),
   在这里由于 `time` 是内建命令 (与 `/usr/bin/time` 冲突)
1. `screen` 玩法:
   - `-ls` -- 列出当前用户分享的 screen
   - `-dmS session` -- 新建一个 session (`-d` 表示不立即附着)
   - `-r` -- (对于本机登录的自己) 恢复离线的 screen 作业
   - `-x` -- (对于别处登录的相同的账号) 恢复作业, 实现同账号分享

   以下操作处于 `screen` 中:
   - `<C-a> d` -- 从 `screen` 中脱离 (注: 直接 `<C-d>` 会关闭这个 `screen` !)
   - `<C-a> s` -- 冻结屏幕
   - `<C-a> q` -- 恢复冻结的屏幕
   - `<C-a> :multiuser on` -- 开始多用户模式
   - `<C-a> :acladd USER` -- 多用户模式中允许用户 `USER` 访问

   要实现不同账号分享, 首先在 `root` 权限下执行:
   ```sh
   chmod u+s $(which screen)
   chmod 755 /var/run/screen
   rm -fr /var/run/screen/*
   ```
   再开启多用户模式, 添加用户访问权限, 其它用户通过命令 `screen -x usera/shared` 即可.
1. Zsh 中的 `nohup` 与 Bash 有所不同: 关闭 shell 后仍然会停止后台任务.
   解决方案:
   - `nohup <command> & disown`
   - `<command> &!`
   - `setopt NO_HUP`
1. 获得指定用户登录 Shell 路径: `getent passwd $LOGNAME | cut -d: -f7`
1. 配置静态 DNS (Ubuntu): 修改 `/etc/network/interfaces`:
   ```
   ...
   dns-nameservers 223.5.5.5 223.6.6.6
   ...
   ```
