## 开启 swap 分区

1. 创建用于交换分区的文件
   ```
   dd if=/dev/zero of=/mnt/swap bs=block_size count=number_of_block
   ```
   注: `block_size`, `number_of_block` 大小可以自定义,
   比如 `bs=1M`, `count=1024`, 代表设置 1G 大小 swap 分区

2. 设置交换分区文件
   ```
   mkswap /mnt/swap
   ```

3. 立即启用交换分区文件
   ```
   swapon /mnt/swap
   ```
   如果在 `/etc/rc.local` 中有 `swapoff -a` 需要修改为 `swapon -a`

4. 设置开机时自启用 `swap` 分区
   ```
   需要修改文件 `/etc/fstab` 中的 `swap` 行
   ```
   添加 `/mnt/swap swap swap defaults 0 0`

   注: `/mnt/swap` 路径可以修改, 可以根据创建的 `swap` 文件具体路径来配置

设置后可以执行 `free -m` 命令查看效果


### 参考

- [针对阿里云及腾讯云等默认不开启swap分区解决办法](http://www.jiankang37.com/archives/69)
