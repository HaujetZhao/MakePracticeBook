@echo off
setlocal enabledelayedexpansion

REM ������һ���ļ��к�
REM �ýű�������ļ�����ȫ���� jpg �ļ�
REM ������������������ƴ��
REM ������ʣ���ţ��ͽ����ĸ߶�������2��

R

REM ��ʼ��
set /a cnt=0
set /a num_files=0
set last_file=

for %%a in ("%~1\*.jpg") do (
      set /a num_files+=1
)

if !num_files! EQU 0 (
      echo δ�ҵ� jpg �ļ�
      goto :eof
)

for %%a in ("%~1\*.jpg") do (
    set /a last_cnt=!cnt!
    set /a cnt+=1
    
    REM �ж��Ƿ�Ϊ������
    set /a odd=!cnt!%%2

    if !cnt! EQU !num_files! (
        if !odd! EQU 1 (
            magick "%%a" -gravity north -extent %%wx%%[fx:h*2] "%%a"
            echo �������һ���ļ����߶�����Ϊ2��...
            goto :finish
        )
    )
        
    if !odd! EQU 0 (
        REM ����ֵ���ż�����ˣ��Ǿͺϲ�
        magick convert "!last_file!" "%%a" -append "!last_file!"
        del "%%a"
        echo �� !last_cnt! �� !cnt! ƴ������...
    ) else (
        REM ����ֵ����������ˣ��Ǿͼ���
        set last_file=%%a
        echo �� !cnt! ��Ϊ���һ���ļ�...
    )

)

:finish
echo ���
pause
