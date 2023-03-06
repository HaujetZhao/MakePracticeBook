@echo off

setlocal enabledelayedexpansion

REM 在这里判断一下是否传入了一个文件夹
set attr=%~a1
if "!attr:~0,1!" neq "d" (
  echo 错误：传入的参数应该是一个文件夹
  pause
  exit /b 1
)


set "BACKGROUND=背景.png"
set FOREGROUND=
set "composite_options=-geometry +0+100"

for /r %1 %%i in (*.jpg) do (
  set FOREGROUND=%%i
  echo 正在处理文件 %%i ...
  magick composite -gravity north %composite_options%  "!FOREGROUND!" "!BACKGROUND!" -colorspace RGB "%%i"
)
pause
echo All done.
