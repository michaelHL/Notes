## 利用 ssh 穿透内网

### 记号

| 代号 | 位置          | 地址      | 账户  |
| :--: | :--:          | :--:      | :--:  |
| A    | 位于公网      | a.site    | usera |
| B    | 位于 NAT 之后 | localhost | userb |
| C    | 位于 NAT 之后 | localhost | userc |

### 操作

1. 在机器 A 上:
   - 设置 `sshd` 设置文件 `/etc/ssh/sshd_config`: `GatewayPorts yes`
   - `sudo systemctl restart sshd`
1. 在机器 B 上:
   创建 SSH 密钥, 上传至 A:
   ```
   ssh-keygen -t 'rsa'
   ssh-copy-id usera@a.site
   ```
   一路回车即可
1.
   - 如果仅作测试, 直接键入命令
     ```
     autossh -M 6777 -NR 6766:localhost:22 usera@a.site -i /path/to/id_rsa
     ```
     即可, 但该命令会在前端等待. 但如果需要不间断运行地置于后台,
     可使用 `nohup` 命令:
     ```
     nohup autossh -M 6777 -NR 6766:localhost:22 usera@a.site -i /path/to/id_rsa >/dev/null 2>&1 &
     ```
   - 如果希望作为系统服务并开机启动, 需进行如下操作:
     1. 编辑文件 `/etc/systemd/system/autossh.service`,
        ```
        [Unit]
        Description=autossh database
        After=network-online.target

        [Service]
        Environment="AUTOSSH_GATETIME=0"
        ExecStart=/usr/bin/autossh -M 0 -o "ExitOnForwardFailure=yes" -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" -NR 6766:localhost:22 usera@a.site -i /path/to/id_rsa

        [Install]
        WantedBy=multi-user.target
        ```
     1. 一通令之生效的操作:
        ```
        sudo systemctl daemon-reload
        sudo systemctl enable autossh
        sudo systemctl start autossh
        sudo systemctl status autossh
        ```

    **注**  
    - `*.service` 文件中需要写绝对路径
    - `systemctl enable` 表示设置服务为自动启动

**开耍**:

- A 连 B: `ssh -p 6766 userb@localhost`
- C 连 B: `ssh -p 6766 userb@a.site`
- 反向连接时指定动态端口转发(机器 C): `ssh -p 6766 -qngfNTD 7677 userb@a.site`

---

### 超时问题

- 在 B 和 C 的`/etc/ssh/ssh_config`后面加上: `ServerAliveInterval 60`
- 在 A 机的`/etc/ssh/sshd_config`后面加上： `ClientAliveInterval 60`

### 参考

- [AutoSSH reverse tunnel service config for systemd](https://gist.github.com/ntrepid8/0af12c012dd2567c800799d86eb44f90)
- [使用SSH反向隧道进行内网穿透](http://arondight.me/2016/02/17/%E4%BD%BF%E7%94%A8SSH%E5%8F%8D%E5%90%91%E9%9A%A7%E9%81%93%E8%BF%9B%E8%A1%8C%E5%86%85%E7%BD%91%E7%A9%BF%E9%80%8F)
- [SSH端口转发：实现反向SSH隧道内网穿透](http://www.huangwenchao.com.cn/2016/10/ssh-reverse-tunnel.html)
