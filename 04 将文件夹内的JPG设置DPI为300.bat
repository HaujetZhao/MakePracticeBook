@echo off
setlocal enabledelayedexpansion


REM �������ж�һ���Ƿ�����һ���ļ���
set attr=%~a1
if "!attr:~0,1!" neq "d" (
  echo ���󣺴���Ĳ���Ӧ����һ���ļ���
  pause
  exit /b 1
)

REM �����ļ�������ļ�
for /r %1 %%a in (*.jpg) do (
  REM ʹ��ImageMagick��dpi����Ϊ300
  echo ���ڴ����ļ� %%a ...
  magick "%%a" -density 300 -units PixelsPerInch "%%a"
)

echo �������
pause
exit /b 0

