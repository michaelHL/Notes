## Conda 使用小结

> Conda 既可以管理包, 还是个「环境」管理器. 包管理器可以帮助查找以及安装包,
> 但是如果需要使用不同版本的 Python, 那就需要有不同的环境.

### 设置国内镜像

没的说, 这步十分重要.

```bash
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --set show_channel_urls yes
```

之后 `~/.condarc` 文件变为:

```
channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
  - defaults
show_channel_urls: true
```

### 更新

Conda 可以更新自身: `conda update conda`; 可以更新 Anaconda:
`conda update anacond`; 可以更新 `Python`, 这里会更新到当前环境下 `Python`
对应的最新版本.

### 环境管理

- 创建环境 snowflakes(目录为 `anaconda/envs/snowflakes` ),
  并安装包 `Biopython`. ( `--name` 可简写为 `-n`, `--envs` 可简写为 `-e`)
  ```bash
  conda create --name snowflakes biopython
  ```
- 创建一个名为 bunnies 的环境, 使用 `python3.5` 作为 Python 环境,
  并安装包 `Astroid`, `Babel`
  ```bash
  conda create --name bunnies python=3.5 astroid babel
  ```
- 激活某个环境 / 取消激活 (返回默认的 `root` 环境), Windows 下无需 `source`
  ```bash
  source activate snowflakes
  source deactivate
  ```
- 列出所有环境, 其中 `*` 表示当前激活环境
  ```bash
  conda info --envs
  ```
- 克隆环境. 基于 snowflakes 克隆出新的 flowers 环境
  ```bash
  conda create --name flowers --clone snowflakes
  ```
- 删除环境
  ```bash
  conda remove --name flowers --all
  ```

### Python 管理

- 检查可用 Python 版本, 其中 `--full-name` 为全字匹配, 去掉即为包含查询
  ```bash
  conda search --full-name python
  ```

### 包管理

- 将 Beautiful Soup 安装至环境 bunnies
  ```bash
  conda install --name bunnies beautifulsoup4
  ```
- 删除包
  ```bash
  conda remove --name bunnies iopro
  ```

### 补充

- 从 **Anaconda 4.1.0** 开始, 一个特别的包 `nb_conda_kernels` 能够自动检测
  Conda 的所有环境并注册这些核到 Jupyter Notebook 里面.
- Windows 中的 Anaconda 新建的新环境安装完 `anaconda`
  包之后才会在开始程序中出现快捷方式
