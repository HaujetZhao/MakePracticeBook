import os
import shlex
import subprocess
import sys
from multiprocessing import Pool


def add_background(filename):
    print(f"正在处理文件 {filename} ...")

    cmd = shlex.split(
        f'magick "{filename}" -density 300 -units PixelsPerInch "{filename}"')
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
