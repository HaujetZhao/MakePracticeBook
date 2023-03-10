@echo off

REM 宽度、高度，单位为 mm
REM 在这里设定背景图大小、DPI
REM 标准的 A4 大小是 210mm * 297mm
REM 标准的 A5 大小是 148mm * 210mm
REM 标准的 A6 大小是 105mm * 148mm

set width=148
set height=105
set dpi=300
set output=背景.png

:: 获取当前脚本所在目录
:: 添加目录到path环境变量中
set script_dir=%~dp0
set path=%path%;%script_dir%

REM 在这里将毫米转换成像素单位
set /a width_px=%width%*%dpi%*10/254
set /a height_px=%height%*%dpi%*10/254

magick -size %width_px%x%height_px%  xc:#FFFFFF  -density %dpi% -units PixelsPerInch %output%
