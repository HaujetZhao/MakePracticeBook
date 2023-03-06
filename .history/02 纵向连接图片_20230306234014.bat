@echo off
setlocal EnableDelayedExpansion

REM 用法：输入多张图片，纵向拼接成一张图片
REM 用途：有一些题会分成两半，写在两页上，如第八页末端和第九页顶端
REM     
set first_file=%1

set cmd=magick 
for %%a in (%*) do set cmd=!cmd! "%%a"
set cmd=!cmd! -append ^"%first_file%^"

!cmd!

echo "图片拼接完成！"

for %%f in (%*) do (
    if not "%%~f"=="%first_file%" (
        echo 正在删除 %%f
        del "%%~f" /q
    )
)

pause
