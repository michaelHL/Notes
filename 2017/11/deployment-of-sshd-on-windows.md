## Windows 下利用 MSYS2 搭建 sshd 服务器

记录 Windows 下清真搭建 sshd 服务全过程.

### 配置 sshd 服务

脚本: [sshd_msys.sh](src/sshd_msys.sh), 注意其中的 `tmp_pass` 可作为登录密码.

1. 以管理员身份登录 **MinGW64**
1. 手动创建一些文件
   ```bash
   # mkpasswd > /etc/passwd
   touch /var/log/lastlog
   ```
1. 为灵活切换 `MSYS` / `MINGW64` / `MINGW32` 环境,
   将 `/etc/ssh/sshd_config` 文件中的 `PermitUserEnvironment` 置为 `yes`,
   新建文件 `~/.ssh/environment` 并在其中添加 `MSYSTEM=MINGW64`
1. `net start/stop sshd` 可启用 / 停止 `sshd` 服务
   (此服务在系统的 `Services` 中的服务名为 `sshd`, 登录账号应为 `.\sshd_server`)

### 配置反向代理 ssh 服务

MSYS2 默认的源中没有 `autossh`, 所以需自行编译: [repo][autossh-additional-pkgs-repo].

一通操作:

```bash
git clone https://github.com/mati865/MSYS2-additional-packages.git
cd MSYS2-additional-packages/autossh
makepkg
pacman -U autossh*.pkg.tar.xz
```

如安装顺利, 则二进制文件为 `/usr/bin/autossh`. 安装系统服务:

```bash
# ssh-keygen -t 'rsa'
ssh-copy-id user@domain
cygrunsrv -R autossh_12345
cygrunsrv -I autossh_12345 -d "MSYS2 Reverse Tunnel - xxxx" -p \
          /usr/bin/autossh.exe -a "-M 0 -o ExitOnForwardFailure=yes -o \
          ServerAliveInterval=30 -o ServerAliveCountMax=3 \
          -o ExitOnForwardFailure=yes \
          -NR 12345:localhost:22 user@domain -i ~/.ssh/id_rsa" \
          -y tcpip -u ".\${USER}" -w "${PASSWD}"
cygrunsrv -S autossh_12345
```

那么就在系统中注册了名为 `autossh_xxxx` 的服务,
其中 `${USER}`, `${PASSWD}` 分别为系统用户名和密码,
启动 / 停止服务同上述 `sshd` 服务.

`autossh` 参数解释:

- `-I` 或 `--install`: 安装服务
- `-d`: 显示名
- `-p`: 程序路径
- `-a`: 参数
- `-y`: 服务依赖, 服务名可直接在 `services.msc`查询
- `-t`: 服务启动类型 (auto | manual)

### 注意

开始试验时经常出现重启后无法连接的情况, 就上述例子而言,
开机后打开日志 `/var/log/autossh_12345.log` 会显示:
```
Error: remote port forwarding failed for listen port 12345
```
详情见 [SSH remote port forwarding failed][se-595323].
经过几十次的重启, 处理方案如下:

- `autossh` 服务中的启动需加上 `-o ExitOnForwardFailure=yes`
- 关机前务必停止 `autossh` 服务, 这里可以对关机、重启命令进行包装:
  ```bash
  alias poweroff='(net stop autossh_xxxx &); (shutdown -s -t 0 &)'
  alias reboot='(net stop autossh_xxxx &); (shutdown -r -t 0 &)'
  ```
  而且该命令需要在管理员权限下执行, 或者在远程执行
- 不要试图更改服务中的登录选项, 仅本机账密才能行的通
- 可能需要设置失败后重启服务

### 参考

- [Configure sshd on MSYS2 and run it as a Windows service][gist-00ee]
- [Autossh Windows][autossh-windows]

[gist-00ee]: https://gist.github.com/samhocevar/00eec26d9e9988d080ac#gistcomment-1508583
[autossh-additional-pkgs-repo]: https://github.com/mati865/MSYS2-additional-packages
[autossh-windows]: https://support.chartio.com/docs/data-sources/autossh-windows
[se-595323]: https://serverfault.com/questions/595323/ssh-remote-port-forwarding-failed
