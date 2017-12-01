## Linux 下的密码管理器 -- pass

一般源都包含 `pass`, 直接 `apt` / `yum` / `pacman` 即可.

1. 首先创建 `gpg` 密钥对: `gpg --gen-key`
1. 依次选择 `(1) RSA and RSA (default)`, `0 = key does not expire`,
   自定义 `Real name`, `Email address` 即可
1. 初始化密码仓库: `pass init <gpg-id>`, 其中的 `<gpg-id>` 便为上面的
   `Real name`

基本使用方法:

- `pass insert <password-name> [-m]`: (是否细致化) 增加密码项,
  其中 `<password-name>` 可以通过 `/` 来建立层级, 放映在目录上就是父子目录
- `pass`: 查看所有密码
- `pass <password-name>`: 取回密码信息
- `pass generate <password-name> n`: 生成 10 个字符的密码
- `pass rm <password-name>`: 删除密码项

其它:

- `gpg` 列出密钥: `gpg --list-keys`. 第一行是公钥文件路径,
  第二行是公钥信息, 第三行是用户 ID, 第四行是私钥信息
