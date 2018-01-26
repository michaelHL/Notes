## Python 3 拾零

1. 编码声明. `python` 文件前两行的注释若能被正则匹配到
   `coding[=:]\s*([-\w.]+)`, 则括号中的内容即被认为是文档编码声明.
   一般花哨的形式有 (GNU Emacs):
   ```python
   # -*- coding: <encoding-name> -*-
   ```
   或 (Bram Moolenaar’s VIM):
   ```python
   # vim:fileencoding=<encoding-name>
   ```
   文档搜索关键字: `Encoding declarations`
1. 正则模块函数 `re.match` 仅从字符串开头开始匹配
1. Jupyter Notebook 分享代码 http://nbviewer.ipython.org
1. 推荐 Python 安装包国内镜像网站: http://mirrors.sohu.com/python
1. Jupyter Notebook 更改 MathJax 字体方法:
   https://stackoverflow.com/a/44290246/4154610
