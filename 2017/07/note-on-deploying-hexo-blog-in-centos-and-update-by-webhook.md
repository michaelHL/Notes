## CentOS 服务器部署 Hexo 博客并利用 Webhook 自动更新

### 1. 部署本地 Hexo 博客以及同步到 Github

#### 安装

[Hexo, A fast, simple & powerful blog framework.](https://hexo.io/)

根据 Hexo 官网的介绍, 首先要安装 `Git` 以及 `Nodejs`,
CentOS 系统下直接 `yum` 安装即可:

```sh
yum install git
yum install nodejs
```

<!-- more -->

两个工具都装好之后, 利用 `npm` 安装 `hexo`:

```sh
npm install hexo-cli -g
```

注意 `npm` 安装的包在 `~/.npm` 目录下(所以是用户级别的).

#### 配置

初始化Hexo:

```sh
mkdir ~/Hexo
cd ~/Hexo
hexo init
npm install
```

`Hexo` 文件夹下的 `_config.yml` 为站点配置文件, 比如

```yaml
# Site
title:
subtitle:
description:
author:
language:
timezone:
```

#### 服务器

这里是按照 Hexo 官网的介绍摘过来的, 应是类似于本机查看渲染效果,
但由于在服务器端, 感觉用不上.

安装 `hexo-server` 包:

```sh
npm install hexo-server --save
```

那么输入

```sh
hexo server
```

网站就会在 `http://localhost:4000` 下启动, 并且 Hexo 会监视文件变动并更新,
如需改变端口或遇到 `EADDRINUSE` 错误, 加上 `-p` 参数并指定端口:

```sh
hexo server -p 5000
```

#### 生成器

利用 `hexo generate` 或者 `hexo g` 即可生成静态文件,
生成的文件目录为 `~/Hexo/public`.

#### 同步

安装[hexo-deployer-git](https://github.com/hexojs/hexo-deployer-git):

```sh
npm install hexo-deployer-git --save
```

在前述 `_config.yml` 文件中, 找到 `deploy` 项, 配置为:

```yaml
deploy:
  type: git
  repo: git@github.com:xxx/blog.git
  branch: master
```

**注** 这里将 Github 上的仓库命名为 `blog`, 与后文中本地仓库名相同.

直接利用 `hexo deploy` 或 `hexo d` 直接push到Github上.
生成静态文件与同步可以合为一步(两者作用相同):

```sh
hexo g -d
hexo d -g
```

详细配置过程见[官方文档](https://hexo.io/zh-cn/docs/deployment.html).

### 2. 配置Nginx

添加[Nginx](https://nginx.org/)的repo并安装:

```sh
rpm -ivh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
yum info nginx
yum install nginx
```

`Nginx` 二进制文件所在目录为 `/usr/sbin/nginx`, 配置目录为 `/etc/nginx/`.
由于 `/etc/nginx/nginx.conf` 文件中包含

```
include /etc/nginx/conf.d/*.conf;
```

所以仅需在 `/etc/nginx/conf.d/` 下新建 `hexo.conf` 文件, 配置网站信息即可:

```
server {
  listen 80;
  server_name domain.com;
  root /var/www/blog;
  index  index.html index.htm;
}
```

- 启动Nginx服务: `service nginx start`
- 重载Nginx服务: `service nginx reload`

这里的 `root` 即为网站所在目录, 大量的教程中将 `/var/www/` 设成网站所在目录,
估计是约定俗成吧. 那么这里就有权限问题了,
刚入坑的我还并不是很了解Linux的权限机制, 所以干脆决定在普通用户下生成静态文件,
并同步至Github, 再利用系统用户利用Webhook从Github更新网站目录.

### 3. Github自动同步到服务器

以 `root` 用户登录, 创建两个文件:

- `sync.sh`: 用于从Github上pull数据, 即更新本地网站目录,
  注意加上执行权限
   ```sh
   #!/bin/bash
   echo -e "\033[32m [AUTO SYNC] sync hexo start \033[0m"
   cd /var/www/blog
   echo -e "\033[32m [AUTO SYNC] git pull...  \033[0m"
   git fetch --all
   git reset --hard origin/master
   git pull
   echo -e "\033[32m [AUTO SYNC] sync hexo finish \033[0m"
   ```
- `hexo-server.js`: 接受Github的post信息后执行 `sync.sh`
  ```javascript
  var http = require('http')
  var exec = require('child_process').exec
  var createHandler = require('github-webhook-handler')
  var handler = createHandler({ path: '/webhook', secret: '******' })

  http.createServer(function (req, res) {
    handler(req, res, function (err) {
      res.statusCode = 404
      res.end('no such location')
    })
  }).listen(7777)

  handler.on('error', function (err) {
    console.error('Error:', err.message)
  })

  handler.on('push', function (event) {
    console.log('Received a push event for %s to %s',
      event.payload.repository.name,
      event.payload.ref)
    exec('/root/Scripts/sync.sh', function(err, stdout, stderr){
      if(err) {
        console.log('sync server err: ' + stderr)
      } else {
        console.log(stdout)
      }
    })
  })

  handler.on('issues', function (event) {
    console.log('Received an issue event for %s action=%s: #%d %s',
      event.payload.repository.name,
      event.payload.action,
      event.payload.issue.number,
      event.payload.issue.title)
  })
  ```

注意 `hexo-server.js` 中的 `sync.sh` 填写的是绝对路径.
安装 `github-webhook-handler` 以及 `forever`:

```sh
npm install github-webhook-handler
npm install forever -g
```

在Github的仓库设置的Webhooks选项中, `Payload URL` 填写为:

```
http://domain.com:7777/webhook
```

这里的端口7777与上面 `hexo-server.js` 中设定的端口是一致的,
`Content type` 选择 `application/json`, 秘钥 `Secret` 自行设置,
与上述 `js` 文件中 `******` 相同. 触发事件选择仅 `push` 的时候即可.

之前生成静态文件并更新至Github时发现Webhooks设置页面最下方的记录中, 总出现

```
We couldn’t deliver this payload: Service Timeout
```

的提示, 当然外网访问的博客也没有更新, 说明是Github与阿里云服务器的沟通出了问题.
结合之前部署RStudio服务器的经历, 想起阿里云服务器配备了安全组,
所以在阿里云服务器安全组规则设置页面中开放7777端口, 这样才能正常访问.
这里不知道是否可用Nginx来做中转, 以后再折腾.

利用之前安装的 `forever` 运行 `js` 脚本:

```
forever start hexo-server.js
```

当然如果要停止这个脚本: `forever stop ***.js`.

于是, 写完博客, `hexo g -d` 同步到Github仓库, 就万事大吉了:
Github接受到这样的一个 `push` 请求之后向服务器特定端口发送了一个HTTP POST,
服务器接受到这个POST后自动执行 `sync.sh`, 也就是到定位本地仓库/网页目录,
从Github上拉取最新的网页文件.

