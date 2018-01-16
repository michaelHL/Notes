## 版本控制系统

1. 利用 `svn` 从远程仓库下载部分目录:
   - GitHub: `svn export https://github.com/<username>/<repo>/trunk/<subdir>`
   - 码云: `svn export svn://git.oschina.net/<username>/<repo>/trunk/<subdir>`
   - 码市: `svn export svn+ssh://svn@svn.coding.net/<username>/<repo>/trunk/<subdir>`
   其中 GitHub 已默认开启 svn; 码云及码市需要手动开启
