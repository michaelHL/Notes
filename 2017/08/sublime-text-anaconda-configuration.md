## Sublime Text 3 与 Anaconda 共舞

不多说, 直接上 **工程** 配置:

```json
{
    "build_systems":
    [
        {
            "env": { "PYTHONIOENCODING": "UTF-8" },
            "file_regex": "^[ ]*File \"(...*?)\", line ([0-9]*)",
            "name": "Anaconda Python Builder",
            "selector": "source.python",
            "shell_cmd": "\"D:\\Anaconda3\\envs\\workspace\\python.exe\" -u \"$file\""
        }
    ],
    "folders":
    [
        {
            "path": "F:\\WorkingDirectory\\Work\\__current"
        },
        {
            "path": "F:\\WorkingDirectory\\Programming"
        },
        {
            "path": "D:\\MSYS2\\home\\Michael\\Notes"
        }
    ],
    "settings":
    {
        "extra_paths":
        [
            "D:\\Anaconda3\\envs\\workspace\\Scripts"
        ],
        "python_interpreter": "D:\\Anaconda3\\envs\\workspace\\python.exe",
        "test_command": "D:\\Anaconda3\\Scripts\\nosetests"
    }
}
```

插件设置:

```json
{
    "pep8_ignore": ["E501", "W292", "E303", "W391", "E111", "E114",
                    "E121", "E201", "E202", "E122", "E116", "E225",
                    "E251", "E261", "E272", "E302", "W293", "E402"],
    "pyflakes_explicit_ignore":
    [
        "UnusedImport"
    ],
    "auto_formatting": true,
    "anaconda_linting": false,
    "suppress_word_completions": false,
    "suppress_explicit_completions": false,
    "enable_signatures_tooltip": true,
    "merge_signatures_and_doc":true,
    "complete_parameters": false,
    "complete_all_parameters": false,
}
```

其中最重要的显中文的即为 `PYTHONIOENCODING` 的配置,
网上关于在 `build_systems` 上面下功夫并没有什么用.

### 参考

[Anaconda Python Builder can't print Chinese characters in Sublime Text 3 Terminal][anaconda-issue-431]

[anaconda-issue-431]: https://github.com/DamnWidget/anaconda/issues/431
