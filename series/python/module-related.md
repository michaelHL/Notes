## Python 专题: 模块相关

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