@echo off


REM ��ȡ��߶ȣ���λΪ mm
REM �������趨����ͼ��С��DPI
REM ��׼�� A5 ��С�� 105mm * 148����
set width=148
set height=105
set dpi=300
set output=����.png

set /a width_px=%width%*%dpi%*10/254
set /a height_px=%height%*%dpi%*10/254

magick -size %width_px%x%height_px%  xc:#FFFFFF  -density %dpi% -units PixelsPerInch %output%
