## Linux终端技巧拾零

1. 使对补全大小写不敏感.  
   所有用户: `/etc/inputrc`  
   当前用户: `~/.inputrc`  
   输入内容: `set completion-ignore-case on`
1. `history`不显示连续、重复、特定的命令、加上时间戳.  
   于`/etc/bashrc`(或`~/.bashrc`)中添加
   ```
   HISTTIMEFORMAT='%F %T '
   HISTCONTROL=erasedups
   HISTIGNORE="ls:pwd:cd:clear:vim:fg:bg:jobs:top"
   ```
   将`HISTCONTROL`设成`ignoredups`仅忽略连续的重复命令,
   而`erasedups`清除整个历史中重复条目.
1. 常用终端快捷键

   | command | trick |
   | :--: | :--:|
   | <kbd>ctrl</kbd> <kbd>a |</kbd> 移动到行首 |

