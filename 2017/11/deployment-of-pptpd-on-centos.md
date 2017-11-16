## CentOS 利用 pptpd 搭建 VPN

> 参考逼友日志 [CentOS上pptpd搭建V*N记录](http://www.cnblogs.com/ocean1100/articles/7847036.html)

### 安装 pptpd

```bash
yum install pptpd
```

### 配置 pptp

1. 配置服务器的DNS
   ```bash
   % vi /etc/ppp/options.pptpd
   #指定 pptpd 服务
   name pptpd
   #指定 DNS
   ms-dns 8.8.8.8
   ms-dns 8.8.4.4
   ```
1. `vi /etc/pptpd.conf`
   ```
   # 取消该行注释
   ppp /usr/sbin/pppd
   # 取消这行注释,这里我写的是三个外网 IP, 表示搭建三个 VPN
   # 自定义服务器虚拟 IP 地址
   localip 10.0.0.1
   # 连接 VPN 服务时分配给客户端的IP地址
   remoteip 10.0.0.2-10,10.0.0.20
   ```
1. 配置登录用户名
   ```
   % vi /etc/ppp/chap-secrets
   # client      server   secret     IP addresses
   　name1 　　 　pptpd 　 passwd1 　　　　*
   ```
1. 重启pptpd服务
   ```
   /etc/init.d/pptpd restart
   ```

### 开启服务器系统路由模式, 支持包转发

编辑 `/etc/sysctl.conf`:

```bash
net.ipv4.ip_forward = 1        # 设置为 1
# net.ipv4.tcp_syncookies = 1  # 注释掉
% /sbin/sysctl -p  # 使设置生效
```

### 设置防火墙转发规则

1. 安装 `iptables`:
   ```
   yum install iptables
   ```
1. 启动 `iptables`:
   ```
   service iptables start
   ```
1. 添加规则:
   ```
   iptables -t nat -A POSTROUTING -s 10.0.0.0/255.255.255.0 -j SNAT --to-source 服务器真实ip
   ```
1. 重启防火墙:
   ```
   /etc/init.d/iptables restart
   ```
1. 设置防火墙开机启动
   ```
   chkconfig iptables on
   ```
1. 查看防火墙配置
   ```
   cat /etc/sysconfig/iptables
   ```

### 设置开机自动建立 ppp 设备节点

**系统重新启动后有可能会丢失此文件, 导致 pptp 客户端拨号出现错误 619**.

1. 于 `/etc/rc.d/rc.local` 末尾添加:
   ```
   mknod /dev/ppp c 108 0
   ```
1. `/etc/sysconfig/iptables` 添加一行:
   ```
   -A INPUT -p gre -j ACCEPT  # 防火墙打开 gre 协议
   ```

至此, CentOS 下 pptpd 搭建完成.
