@echo off


REM ��ȡ��߶ȣ���λΪ mm
set width=210
set height=148
set dpi=300
set output=����.png

set /a width_px=%width%*%dpi%*10/254
set /a height_px=%height%*%dpi%*10/254

magick -size %width_px%x%height_px%  xc:#FFFFFF  -density %dpi% -units PixelsPerInch %output%
