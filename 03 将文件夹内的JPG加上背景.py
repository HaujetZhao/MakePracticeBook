import os
import shlex
import subprocess
import sys
from multiprocessing import Pool


def add_background(filename):
    print(f"正在处理文件 {filename} ...")
    bg_file = "背景.png"

    # 当图片叠加时，-gravity 用于控制对齐方向，north 代表顶对齐
    # -geometry +0+100 表示水平不要偏移，垂直方向往下偏移100个像素
    composite_options = "-geometry +0+100 -gravity north"

    cmd = shlex.split(f'''
        magick composite {composite_options}
        "{filename}" "{bg_file}" -colorspace RGB "{filename}"
        ''')
    subprocess.run(cmd)
    

def main():
    input_folder = sys.argv[1]
    if not os.path.isdir(input_folder):
        print(f"{input_folder} 不是一个有效的文件夹路径")
        return
    filenames = [os.path.join(input_folder, f)
                 for f in os.listdir(input_folder)]
    jpg_filenames = [f for f in filenames if os.path.isfile(
        f) and f.endswith(".jpg")]

    # 多进程处理
    with Pool(processes=8) as pool:
        pool.map(add_background, jpg_filenames)


if __name__ == '__main__':
    main()
    input("按下回车键退出...")
