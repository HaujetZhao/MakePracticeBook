@echo off
setlocal EnableDelayedExpansion

REM �÷����������ͼƬ������ƴ�ӳ�һ��ͼƬ
REM ��;����һЩ���ֳ����룬д����ҳ�ϣ���ڰ�ҳĩ�˺͵ھ�ҳ����
REM       һ������������Ƭ���Ϳ���������ű���������Ƭƴ������

set first_file=%~dpnx1

set cmd=magick 
for %%a in (%*) do set cmd=!cmd! "%%~dpnxa"
set cmd=!cmd! -append ^"%first_file%^"

!cmd!

echo "ͼƬƴ����ɣ�"

for %%f in (%*) do (
    if not "%%~f"=="%first_file%" (
        echo ����ɾ�� %%f
        del "%%~f" /q
    )
)
