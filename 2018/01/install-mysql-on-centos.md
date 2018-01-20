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



[mysql-yum-repo]: https://dev.mysql.com/downloads/repo/yum
