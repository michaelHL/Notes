## U盘安装CentOS7.3

1. Windows 下用 UltraISO 将系统刻入 U 盘
2. 改 BIOS 启动引导项为 U 盘, 进入的第一个界面中将光标移至 `Install ...`,
   按下 <kbd>Tab</kbd>, 修改命令为

   ```bash
   vmlinuz initrd=initrd.img linux dd quiet
   ```

3. 上面的命令只是查询 U 盘的设备号, 比如此次安装时显示出 U 盘的设备号为 `sdb4`,
   按下 <kbd>ctrl</kbd> <kbd>alt</kbd> <kbd>delete</kbd>强制重启,
   在下次的重启选项中键入

   ```bash
   vmlinuz initrd=initrd.img inst.stage2=hd:/dev/sdb4 quiet
   ```

4. 开耍.
