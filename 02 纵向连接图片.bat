@echo off
setlocal EnableDelayedExpansion

REM �÷����������ͼƬ������ƴ�ӳ�һ��ͼƬ
REM ��;����һЩ���ֳ����룬д����ҳ�ϣ���ڰ�ҳĩ�˺͵ھ�ҳ����
REM       һ������������Ƭ���Ϳ���������ű���������Ƭƴ������

:: ��ȡ��ǰ�ű�����Ŀ¼
:: ���Ŀ¼��path����������
set script_dir=%~dp0
set path=%path%;%script_dir%

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
