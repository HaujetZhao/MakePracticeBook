@echo off
setlocal EnableDelayedExpansion

REM �÷����������ͼƬ������ƴ�ӳ�һ��ͼƬ

set first_file=%1

set cmd=magick 
for %%a in (%*) do set cmd=!cmd! "%%a"
set cmd=!cmd! -append ^"%first_file%^"

!cmd!

echo "ͼƬƴ����ɣ�"

for %%f in (%*) do (
    if not "%%~f"=="%first_file%" (
        echo ����ɾ�� %%f
        del "%%~f" /q
    )
)

pause
