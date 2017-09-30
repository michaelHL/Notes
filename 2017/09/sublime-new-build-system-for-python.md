## Sublime Text 3 中为 Python 新建 Build System

`Tools` → `Build System` → `New Build System`, 其默认的选项为 `cmd_shell`,
但不是很好使, 所以改为 Sublime Text 2 时代的 `cmd` + `shell`.

如果在写 Python 脚本的时候需要进行交互, 最好能跳出终端, 新建 Build System 如下:

```json
{
    "cmd": ["start", "cmd", "/c", "python -u $file & pause"],
    "shell": true,
    "selector": "source.python",
    "file_regex": "^[ ]*File \"(...*?)\", line ([0-9]*)"
}
```
