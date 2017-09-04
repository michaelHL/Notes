## Python 专题: 正则相关

- 为什么对于正则中的「模式」采用原始字符串:

  This is important in regular expressions,
  > as you need the backslash to make it to the `re` module intact -
  > in particular, `\b` matches empty string specifically at the start
  > and end of a word. `re` expects the string `\b`, however normal string
  > interpretation `'\b'` is converted to the ASCII backspace character,
  > so you need to either explicitly escape the backslash (`'\\b'`),
  > or tell python it is a raw string (`r'\b'`).

  参考: [What does the “r” in pythons re.compile(r' pattern flags') mean?][stack-r-pattern].


[stack-r-pattern]: https://stackoverflow.com/questions/21104476/what-does-the-r-in-pythons-re-compiler-pattern-flags-mean
