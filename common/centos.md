## CentOS 服务器摘记

1. 必要的EPEL包: `yum install -y epel-release`
1. 查看CentOS系统realse版本: `cat /etc/readhat-release`
1. 电源管理, 笔记本合盖子问题.
   参考[Linux CentOS 7电源管理设置（合盖不睡眠）](http://www.jianshu.com/p/f8f2692b1d7a)  
   `systemd` 处理某些电源相关的ACPI事件，可以通过从 `/etc/systemd/logind.conf`
   以下选项进行配置:
   - `HandlePowerKey` 按下电源键后的行为，默认 `power off`
   - `HandleSleepKey` 按下挂起键后的行为，默认 `suspend`
   - `HandleHibernateKey` 按下休眠键后的行为，默认 `hibernate`
   - `HandleLidSwitch` 合上笔记本盖后的行为，默认 `suspend`
   如果要合盖不休眠只需要把 `HandleLidSwitch` 选项设置为如下即可:
   `HandleLidSwitch=lock`, 并运行下列命令才生效:
   `systemctl restart systemd-logind`
1. 解压 `.bz2` 文件失败: `yum install install bzip2`
1. 控制台下配置基本网络连接工具: `nmtui` (curses-based text user interface).
1. `rstudio-server` 的 help 窗口用的 `R.css` 路径:
   `/usr/lib/rstudio-server/resources`
1. Xshell 下不小心按 Ctrl-S 假死: <kbd>ctrl</kbd><kbd>s</kbd> 锁屏!
   <kbd>ctrl</kbd><kbd>q</kbd> 可恢复
