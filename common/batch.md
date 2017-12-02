## 小东西 -- Windows 脚本语言

#### 图片批量转 gif

```batch
@echo off
set postfix_img=.gif

:rec
set fullfilename=%~1
set newfilename=%~d1%~p1%~n1%postfix_img%
set fileext=%~x1
if "%~1" == "" goto done
if not %fileext% == %postfix_img% (
    D:\ImageMagick\convert.exe -delay 20 -loop 0 %fullfilename% %newfilename%
    del %fullfilename%
)
shift
goto rec

:done
```

#### 安装字体

```
xcopy /Y myfonts\*.ttf C:\Windows\Fonts\
```
