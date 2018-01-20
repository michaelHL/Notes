## CentOS 系统部署MySQL 5.7

1. 添加 MySQL 的 Yum 仓库: [Download MySQL Yum Repository][mysql-yum-repo].
   ```
   wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
   rpm -ivh mysql57-community-release-el7-11.noarch.rpm
   yum install mysql-server
   ```
1. 启动 MySQL 服务:
   ```
   systemctl start mysqld
   systemctl status mysqld
   ```
1. 更改 root 用户密码:
   ```
   mysqladmin -uroot password -p
   <password>
   ```
1. 允许远程访问:
   ```
   % mysql -uroot -p
   grant all privileges on *.* to 'root' @'%' identified by '<password>';
   flush privileges;
   ```

### 配置文件

`/etc/my.cnf`

```
# For advice on how to change settings please see
# http://dev.mysql.com/doc/refman/5.7/en/server-configuration-defaults.html

[mysql]
default-character-set=utf8

[mysqld]
# join_buffer_size = 128M
# sort_buffer_size = 2M
# read_rnd_buffer_size = 2M
port=33333
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
character-set-server=utf8
symbolic-links=0
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid
```


### 问题

#### rpm 无法添加仓库

如果不是全新安装, 需要手动删除之前用 rpm 安装的 mysql 相关的包

#### 服务无法启动

重设 MySQL 数据目录的权限:

```
chmod -R 777 /var/lib/mysql
```

###

- [centos7 mysql数据库安装和配置][cnblogs-4680083]
- [CentOS 7 下开启Mysql-5.7.19远程访问][csdn-76381632]
- [CentOS7 64位下MySQL5.7安装与配置（YUM）][linuxidc-135288]
- [RPM命令详解（安装、升级、卸载）][csdn-rpm]
- [Configuring A Fresh Install Of MySQL On CentOS: Start Service, Set Password, Set Runlevels][linuxacademy-config-fresh-install-mysql]

[linuxidc-135288]: http://www.linuxidc.com/Linux/2016-09/135288.htm
[cnblogs-4680083]: https://www.cnblogs.com/starof/p/4680083.html
[csdn-rpm]: http://blog.csdn.net/samxx8/article/details/46739005
[mysql-yum-repo]: https://dev.mysql.com/downloads/repo/yum
[csdn-76381632]: http://blog.csdn.net/u010758410/article/details/76381632
[linuxacademy-config-fresh-install-mysql]: https://linuxacademy.com/blog/linux/configuring-a-fresh-install-of-mysql-on-centos-start-service-set-password-set-runlevels
