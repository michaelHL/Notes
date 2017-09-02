## Python 专题: 模块, 包相关

- 从技术上讲, Python 把载入的模块存储到 `sys.modules` 表中,
  并在一次导入操作的开始检查该表
- 模块搜索路径:
  - 程序主目录
  - `PYTHONAPTH` 环境变量目录
  - 标准链接库目录
  - 任何 `.pth` 文件的内容
- 可以通过 `sys.path` 查看模块搜索路径在机器上的实际配置
- 如何理解一个文件生成命名空间:
  - 模块语句会在首次导入时运行
  - 顶层的赋值语句会创建模块属性
  - 模块的命名空间能通过属性 `__dict__` 或 `dir(M)` 来获取
  - 模块是一个独立的作用域(本地变量就是全局变量)
- 关于 `os.path` 的问题. 在 Linux 平台下的 Python 交互窗口中输入:
  ```bash
  python -c "import sys; print('\n'.join(list(sys.modules.keys())))" | grep os
  ```
  返回 `posix`, `os`, `posixpath`, `os.path`, 说明 Python 启动时,
  已经将 `os`, `os.path` 模块载入. 如果仅 `import os`,
  那么可以发现 `os.path` 绑定至一个模块对象, 相当于 `import os.path`.
