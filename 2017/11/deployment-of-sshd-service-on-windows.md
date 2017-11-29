## Windows 下利用 MSYS 搭建 sshd 服务器

### 配置 sshd 服务

脚本: [sshd_msys.sh](../src/sshd_msys.sh), 注意其中的 `tmp_pass` 可作为登录密码.

1. 以管理员身份登录 MSYS
1. 手动创建一些文件
   ```bash
   mkpasswd > /etc/passwd
   var/log/lastlog
   ```
1. 为灵活切换 `MSYS` / `MINGW64` / `MINGW32` 环境,
   将 /etc/ssh/sshd_config` 文件中 `PermitUserEnvironment` 置为 `yes`,
   并在 `~/.ssh/environment` 文件中添加 `MSYSTEM=MINGW64`
1. `net start/stop sshd` 可启用 / 停止 `sshd` 服务

### 配置反向代理 ssh 服务


- [autossh][autossh-additional-pkgs-repo]



[msys2]: http://www.msys2.org
[autossh-additional-pkgs-repo]: https://github.com/mati865/MSYS2-additional-packages
