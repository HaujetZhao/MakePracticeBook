@echo off


REM 宽度、高度，单位为 mm
REM 在这里设定背景图大小、DPI
REM 标准的 A5 大小是 105mm * 148毫米
set width=148
set height=105
set dpi=300
set output=背景.png

set /a width_px=%width%*%dpi%*10/254
set /a height_px=%height%*%dpi%*10/254

magick -size %width_px%x%height_px%  xc:#FFFFFF  -density %dpi% -units PixelsPerInch %output%
