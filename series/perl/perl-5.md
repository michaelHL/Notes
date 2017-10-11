## Perl 5 拾零

- `use 5.016` 表示程序只能在 Perl 5.16 以上的版本运行,
  另外版本号一定要写成三位数, 包括前导零
- [非]十进制整数直接量可以用 `_` 分隔以提高阅读体验,
  比如 `0x50_65_72_7c`
- 字符串用点号 `.` 拼接
- 字符串重复操作符 `x` 可以让左边的操作数重复右边的操作数进行连接
- 语句末尾的 `;` 除了在块中末尾行, 都是必须的
- 单引号内能转义的字符仅有 `'` 及 '\'
- 双引号内字符串的转义字符有(特殊):
  - `\e` -- Esc (ASCII 编码的转义字符)
  - `\007` -- 八进制
  - `\x7f` -- 十六进制
  - `\x{2744}` -- 十六进制的 Unicode 代码点
  - `\cC` -- Control 键的代码
  - `\l` / `\L` -- 将下个/后面所有字母转为小写
  - `\u` / `\U` -- 将下个/后面所有字母转为大写
  - `\Q` -- 把它到 `\E` 之间的非单词字符加上反斜线转义
  - `\E` -- 结束 `\L`, `\U`, `\Q` 开始的作用范围
- 获取用户输入并去除末尾的换行符(标量 / 数组):
  ```perl
  chomp(my $text = <STDIN>);
  chomp(my @texts = <STDIN>);
  ```
- 判断是否为 `undef`: `defined` 函数
- `$#foo` 返回 `@foo` 的最大索引值
- 数组内插到双引号串中时自动添加分隔用的空格, 空格这个分隔符的变量为 `$"`
- `each` 操作符与 Python 中的 `enumerate` 相似, 会返回数组中的元素索引以及值
- 强制指定标量上下文, 比如
  ```perl
  my @rocks = qw ! talc quartz jade obsidian !;
  print "How many rocks do you have?\n";
  print "I have ", @rocks, " rocks!\n";
  print "I have ", scalar @rocks, " rocks!\n";
  ```
- 避免子程序名称与内置函数重名, 应使用 `&`, 或者打开警告开关 `use warnings`
- 不能在 `qw` 函数中运用字符串插值
- 如果 `print` 或者其它函数名后面接着一个左括号, 务必保证这个括号是成对的
- 赋值语句返回实际的变量作为左值
- 在同一个正则表达式中, 反向引用为 `\1`, 否则使用 `$1`
- Perl 提供两种类型的名字空间, 符号表 (symbol table) 和词法作用域
  (lexical scope).
- `$str =~ tr/x//` 仅统计 `$str` 中 `x` 的数量, 而 `tr/x//d` 删除所有的 `x`
- Windows 用 StrawBerry Perl 安装 CPAN 包时, 注意将包含 StrawBerry 的 GCC
  工具链优先级提前或者删除其它可能影响编译的路径,
  部分包需要强制安装: `cpan -fi Tk`
- Windows 下 `cpan` 安装包遇到网络环境差如何设置代理:
  ```
  % set http_proxy=http://127.0.0.1:1234
  % cpan -fi xx::xx
  ```
