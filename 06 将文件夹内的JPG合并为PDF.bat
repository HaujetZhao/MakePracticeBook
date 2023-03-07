@echo off
setlocal EnableDelayedExpansion

set input_dir=%~dpn1
set output_file=%~n1.pdf

REM ���û�����룬��ֱ���˳�
if not exist "%input_dir%" (
    echo Invalid input directory.
    exit /b 1
)

magick convert "%~dpn1\*.jpg" -compress jpeg -quality 80 "%output_file%"

echo ������ɣ�
pause