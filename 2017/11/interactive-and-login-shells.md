## 交互 Shells 和登录 Shells

有这么些关系 (摘自 [Interactive and Login Shells][gist-1]):

> It doesn't seem like it's possible for there to be a login shell but not interactive.  
> Cron shell scripts are always non-login and non-interactive.  
> SSH shells are always login and interactive.  
> Subshells are always interactive but not login.  
> Shell scripts are always non-login and non-interactive.  
> Initial TTY shell should be login and interactive.

> Swtching users inside Linux involves creating subshells, can you elect to switch
> without logging in, or switch while simulate the logging in process. Note that
> logging in doesn't necessarily mean you need to enter passwords, nor that any
> password to be entered is possessed by the user you're logging into.

> Since `.bashrc` is read on interactive but not login, and `.bash_profile` is read
> on all login shells. People source the `.bashrc` in the `.bash_profile`, allowing
> you to set general configuration (that applies to all interactive shells) inside
> `.bashrc` but login specific configuration in `.bash_profile`.


[gist-1]: https://gist.github.com/CMCDragonkai/33735c7fa6a2706462f2
