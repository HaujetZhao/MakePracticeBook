@echo off

setlocal enabledelayedexpansion

REM �������ж�һ���Ƿ�����һ���ļ���
set attr=%~a1
if "!attr:~0,1!" neq "d" (
  echo ���󣺴���Ĳ���Ӧ����һ���ļ���
  pause
  exit /b 1
)


set "BACKGROUND=����.png"
set FOREGROUND=

REM ��ͼƬ����ʱ��-gravity ���ڿ��ƶ��뷽��north ��������
REM -geometry +0+100 
set "composite_options=-geometry +0+100 -gravity north"

for /r %1 %%i in (*.jpg) do (
  set FOREGROUND=%%i
  echo ���ڴ����ļ� %%i ...
  magick composite %composite_options%  "!FOREGROUND!" "!BACKGROUND!" -colorspace RGB "%%i"
)
pause
echo All done.
