@echo off
setlocal EnableDelayedExpansion

:: 获取当前脚本所在目录
:: 添加目录到path环境变量中
set script_dir=%~dp0
set path=%path%;%script_dir%

set input_dir=%~dpn1
set output_file=%~n1.pdf

REM 如果没有输入，则直接退出
if not exist "%input_dir%" (
    echo Invalid input directory.
    exit /b 1
)

magick convert "%~dpn1\*.jpg" -compress jpeg -quality 80 "%output_file%"

echo 任务完成！
pause