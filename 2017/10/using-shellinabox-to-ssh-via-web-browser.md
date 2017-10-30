## 利用 shellinabox 实现浏览器中登录 SSH

1. 首先下载 [shellinabox][shellinabox-official]:
   ```
   sudo apt-cache search shellinabox
   sudo yum install openssl shellinabox
   ```
1. 配置文件 `/etc/sysconfig/shellinaboxd` (以 CentOS 7.3 下为例):
   ```
   # Shell in a box daemon configuration
   # For details see shellinaboxd man page
   # Basic options
   USER=shellinabox
   GROUP=shellinabox
   CERTDIR=/var/lib/shellinabox
   PORT=4444
   OPTS="--disable-ssl-menu -s /:LOGIN"
   OPTS="--css white-on-black.css"
   # Additional examples with custom options:
   # Fancy configuration with right-click menu choice for black-on-white:
   # OPTS="--user-css Normal:+black-on-white.css,Reverse:-white-on-black.css --disable-ssl-menu -s /:LOGIN"
   # Simple configuration for running it as an SSH console with SSL disabled:
   # OPTS="-t -s /:SSH:host.example.com"
   ```
1. 上述的 `white-on-black.css` 路径在 `/usr/share/shellinabox/` 下.
   魔改、深度定制:
   ```
   #vt100 #console, #vt100 #alt_console, #vt100 #cursor {
     font-size: 13.7pt;
   }

   #vt100 #lineheight {
     font-size: 14pt;
   }

   ::-webkit-scrollbar {
     display: none;
   }
   ```
   分别修改终端字体、行高以及隐藏白色的滚动条
1. 启动服务:
   ```
   service shellinaboxd start
   ```

### 致谢

- [Web终端之使用shellinabox在浏览器进行ssh登录](http://www.jianshu.com/p/afec77178b67)
- [How to change font and font size?](https://github.com/shellinabox/shellinabox/issues/68)

[shellinabox-official]: https://github.com/SoulSu/shellinabox
