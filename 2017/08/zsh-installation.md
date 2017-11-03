## Zsh 折腾记

**注** 之前的试验场所有 CentOS(本地 + 远程), ~~MSYS2~~ (巨卡无比,
应该是 mintty 的锅, 不过不打算继续折腾这了)

### 安装 Zsh

```bash
yum install zsh
chsh -s /usr/bin/zsh
```

### 安装 Oh-My-Zsh

官方 [repo][oh-my-zsh-repo]

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

或

```bash
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
```

详情请见 oh-my-zsh 的 [wiki][oh-my-zsh-wiki].

### 安装插件 Powerlevel9k

官方 [repo][powerlevel9k-repo]

```bash
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
```

### 配置 `.zshrc`

见 [`.zshrc`](src/.zshrc)

---

秀一发:

<p align="center">
  <img src="img/zsh-on-xshell.png">
</p>

**注** 其中所用字体为 [`SauceCodePro`][nerdfonts-repo]


[oh-my-zsh-repo]: https://github.com/robbyrussell/oh-my-zsh
[oh-my-zsh-wiki]: https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH
[powerlevel9k-repo]: https://github.com/bhilburn/powerlevel9k
[nerdfonts-repo]: https://github.com/buzzkillhardball/nerdfonts
