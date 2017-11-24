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

   | command                                   | trick                  |
   | :---                                      | :---                   |
   | <kbd>ctrl</kbd> <kbd>a</kbd>              | 移动到行首             |
   | <kbd>ctrl</kbd> <kbd>e</kbd>              | 移动到行末             |
   | <kbd>ctrl</kbd> <kbd>b</kbd>              | 移动到前面一个字母     |
   | <kbd>ctrl</kbd> <kbd>f</kbd>              | 移动到后面一个字母     |
   | <kbd>alt</kbd>  <kbd>b</kbd>              | 移动到前面一个单词首位 |
   | <kbd>alt</kbd>  <kbd>f</kbd>              | 移动到后面一个单词首位 |
   | <kbd>ctrl</kbd> <kbd>k</kbd>              | 删除到行末             |
   | <kbd>ctrl</kbd> <kbd>u</kbd>              | 删除到行首             |
   | <kbd>ctrl</kbd> <kbd>x</kbd> <kbd>x</kbd> | 切除至行首、末         |

   注: 上述所有的「移动」均可认为处于Insert模式, 即光标相当于block在左边.
1. `xargs` 处理带有空格文件名文件的问题.  
   比如下列命令对于空格文件名是会出问题的:
   `find . -iname "*.mp3" -print | xargs mplayer`,
   改用: `find . -iname "*.mp3" -print0 | xargs -0 -I mp3file mplayer mp3file`
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
   而具有高级功能的 `/usr/bin/time` 有如下选项:
   - `-o`: 将执行时间写入文件
   - `-a`: 追加信息
   - `-f`: 格式化时间输出
   比如输出带管道命令的运行时间:
   ```bash
   time -f '%es' bash -c './test.py | sort > /dev/null'
   ```
