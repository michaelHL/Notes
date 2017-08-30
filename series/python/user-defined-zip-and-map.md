## 自定义 zip 和 map 函数

在 Python 2.x 中, `map` 函数会将 `None` 补充至返回结果中,
也就是说, 最后返回列表的长度为其参数中长度最长的一个,
这与 Python 3.x 中 `map` 的行为是不同的 (Python 3.x 中会将其截断,
结果返回参数中长度为最短的一个)

可以用如下代码进行模拟:

```python
def myzip(*deqs):
    seqs = [list(S) for S in seqs]
    res = []
    while all(seqs):
        res.append(tuple(S.pop(0) for S in seqs))
    return res

def mymapPad(*seqs, pad=None):
    seqs = [list(S) for S in seqs]
    res = []
    while any(seqs):
        res.append(tuple((S.pop(0) if S else pad) for S in seqs))
    return res
```

其中, `myzip` 函数将参数全部显式转化为列表, 根据所有参数的最小长度进入循环.
因为该函数的目的是「截断」, 所以是「短板效应」.
而且 `mymapPad` 函数中, 应该试图一直「取下去」, 遇到没有元素的参数时,
用 `pad` 进行填充 (默认是 `None`).

同样, 上面的版本直接返回列表, 用 `yield` 版本返回生成器:

```
def myzip(*seqs):
    seqs = [list(S) for S in seqs]
    while all(seqs):
        yield tuple(S.pop(0) for S in seqs)

def mymapPad(*seq, pad=None):
    seqs = [list(S) for S in seqs]
    while any(seqs):
        yield tuple((S.pop(0) if S else pad) for S in seqs)
```

因为循环次数可以事先被确定, 所以有如下不使用循环的版本:

```python
def myzip(*seqs):
    minlen = min(len(S) for S in seqs)
    return [tuple(S[i] for S in seqs) for i in range(minlen)]

def mymapPad(*seqs, pad=None):
    maxlen = max(len(S) for S in seqs)
    return [tuple(S[i] if len(S) > i else pad for S in seqs)
            for i in range(maxlen)]
```

最后一个版本是完全的生成器版本:

```python
def myzip(*seqs):
    minlen = min(len(S) for S in seqs)
    return (tuple(S[i] for S in seqs) for i in range(minlen))
```
