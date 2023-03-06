@echo off
setlocal enabledelayedexpansion


REM 在这里判断一下是否传入了一个文件夹
set attr=%~a1
if "!attr:~0,1!" neq "d" (
  echo 错误：传入的参数应该是一个文件夹
  pause
  exit /b 1
)

REM 迭代文件夹里的文件
for /r %1 %%a in (*.jpg) do (
  REM 使用ImageMagick将dpi设置为300
  echo 正在处理文件 %%a ...
  magick "%%a" -density 300 -units PixelsPerInch "%%a"
)

echo 处理完毕
pause
exit /b 0

