@echo off
setlocal enabledelayedexpansion

REM 当传入一个文件夹后
REM 该脚本会遍历文件夹里全部的 jpg 文件
REM 将他们依次两两上下拼接
REM 如果最后剩单张，就将它的高度扩充至2倍

R

REM 初始化
set /a cnt=0
set /a num_files=0
set last_file=

for %%a in ("%~1\*.jpg") do (
      set /a num_files+=1
)

if !num_files! EQU 0 (
      echo 未找到 jpg 文件
      goto :eof
)

for %%a in ("%~1\*.jpg") do (
    set /a last_cnt=!cnt!
    set /a cnt+=1
    
    REM 判断是否为奇数个
    set /a odd=!cnt!%%2

    if !cnt! EQU !num_files! (
        if !odd! EQU 1 (
            magick "%%a" -gravity north -extent %%wx%%[fx:h*2] "%%a"
            echo 处理最后一个文件，高度扩充为2倍...
            goto :finish
        )
    )
        
    if !odd! EQU 0 (
        REM 如果轮到第偶数个了，那就合并
        magick convert "!last_file!" "%%a" -append "!last_file!"
        del "%%a"
        echo 将 !last_cnt! 和 !cnt! 拼接起来...
    ) else (
        REM 如果轮到第奇数个了，那就继续
        set last_file=%%a
        echo 将 !cnt! 设为最后一个文件...
    )

)

:finish
echo 完成
pause
