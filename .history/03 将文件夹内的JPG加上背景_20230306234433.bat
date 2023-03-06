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

REM 当图片叠加时，-gravity 用于控制对齐方向，north 代表顶对齐
REM -geometry +0+100 
set "composite_options=-geometry +0+100 -gravity north"

for /r %1 %%i in (*.jpg) do (
  set FOREGROUND=%%i
  echo 正在处理文件 %%i ...
  magick composite %composite_options%  "!FOREGROUND!" "!BACKGROUND!" -colorspace RGB "%%i"
)
pause
echo All done.
