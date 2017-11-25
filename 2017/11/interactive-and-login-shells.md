## 交互 Shells 和登录 Shells

有这么些关系 (摘自 [Interactive and Login Shells][gist-1]):

> It doesn't seem like it's possible for there to be a login shell but not interactive.  
> Cron shell scripts are always non-login and non-interactive.  
> SSH shells are always login and interactive.  
> Subshells are always interactive but not login.  
> Shell scripts are always non-login and non-interactive.  
> Initial TTY shell should be login and interactive.
>
> Swtching users inside Linux involves creating subshells, can you elect to switch
> without logging in, or switch while simulate the logging in process. Note that
> logging in doesn't necessarily mean you need to enter passwords, nor that any
> password to be entered is possessed by the user you're logging into.
>
> Since `.bashrc` is read on interactive but not login, and `.bash_profile` is read
> on all login shells. People source the `.bashrc` in the `.bash_profile`, allowing
> you to set general configuration (that applies to all interactive shells) inside
> `.bashrc` but login specific configuration in `.bash_profile`.

下面为具体的解释, 以及不同情况下启动脚本的加载顺序.
(来自 [login/non-login and interactive/non-interactive shells][se-170493])

* **login** shell: A login shell logs you into the system as a spiecified user,
  necessary for this is a username and password.
  When you hit <kbd>ctrl</kbd>+<kbd>alt</kbd>+<kbd>F1</kbd> to login into a
  virtual terminal you get after successful login: a login shell
  (that is interactive). Sourced files:
  * `/etc/profile` and `~/.profile` for Bourne compatible shells (and `/etc/profile.d/*`)
  * `~/.bash_profile` for bash
  * `/etc/zprofile` and `~/.zprofile` for zsh
  * `/etc/csh.login` and `~/.login` for csh

* **non-login** shell: A shell that is executed without logging in,
  necessary for this is a current logged in user.
  When you open a graphic terminal in gnome it is a non-login (interactive) shell.
  Sourced files:
  * `/etc/bashrc` and `~/.bashrc` for bash

* **interactive** shell: A shell (login or non-login) where you can
  interactively type or interrupt commands. For example a gnome terminal
  (non-login) or a virtual terminal (login). In an interactive shell the
  prompt variable must be set (`$PS1`). Sourced files:
  * `/etc/profile` and `~/.profile`
  * `/etc/bashrc` or `/etc/bash.bashrc` for bash

* **non-interactive** shell: A (sub)shell that is probably run from an
  automated process you will see neither input nor outputm when the calling
  process don't handle it. That shell is normally a non-login shell,
  because the calling user has logged in already.
  A shell running a script is always a non-interactive shell,
  but the script can emulate an interactive shell by prompting
  the user to input values. Sourced files:
  * `/etc/bashrc` or `/etc/bash.bashrc` for bash (but,
    mostly you see this at the beginning of the script:
    `[ -z "$PS1" ] && return`. That means don't do anything if it's a non-interactive shell)
  * depending on shell; some of them read the file in the `$ENV` variable

那么如何判断当前 shell 为 `interactive` 或 `login` shell 呢?

- bash
  - To check if you are in an interactive shell:
        [[ $- == *i* ]] && echo 'Interactive' || echo 'Not interactive'
  - To check if you are in a login shell:
        shopt -q login_shell && echo 'Login shell' || echo 'Not login shell'



[gist-1]: https://gist.github.com/CMCDragonkai/33735c7fa6a2706462f2
[se-170493]: https://unix.stackexchange.com/a/170499
