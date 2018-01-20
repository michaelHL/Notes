## Windows 下配置免安装版 MySQL 5.7

1. 于 [MySQL Community Server][mysql-community-server] 下载页面下载 zip 版本并解压,
   比如解压到 `D:\\MySQL` 目录下
1. 于 `MySQL` 根目录添加配置文件 `my.ini`:
   ```
   [mysqld]
   port = 3677
   basedir = "D:\\MySQL"
   datadir = "D:\\MySQL\\data"
   sql_mode = NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES

   max_connections = 200
   character-set-server = utf8
   default-storage-engine = INNODB
   explicit_defaults_for_timestamp=true

   # innodb_buffer_pool_size = 128M
   # join_buffer_size = 128M
   # sort_buffer_size = 2M
   # read_rnd_buffer_size = 2M

   [mysqladmin]
   user = "root"
   port = 3677
   ```
1. 初始化 MySQL 数据库:
   ```
   "D:\MySQL\bin\mysqld.exe" --defaults-file="D:\\MySQL\\my.ini" --initialize-insecure --console
   ```
1. 此时已有无密码账户 `root`, 更改密码:
   ```
   "D:\MySQL\bin\mysqld.exe" --defaults-file="D:\\MySQL\\my.ini" --console --skip-grant-tables
   ```
1. 另开终端, 输入 `mysql -uroot -P 3677 -p` 直接回车,
   并键入:
   ```
   update mysql.user set authentication_string=password('<password>') where user='root';
   flush privileges;
   quit;
   ```
1. 安装 MySQL 服务. 在 **`D:\MySQL\bin`** 目录下以管理员身份键入 `mysqld --install`

[mysql-community-server]: https://dev.mysql.com/downloads/mysql
