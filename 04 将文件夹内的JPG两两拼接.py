import os
import sys
import shlex
import subprocess
import tempfile
import shutil
from multiprocessing import Pool


# 用 magick 将第二张图片纵向拼接在第一张图片下方
def append_images(pair_list):
    img1 = pair_list[0]
    img2 = pair_list[1]
    print(f"正在拼接:\n    {img1}\n    {img2}")
    cmd = shlex.split(f'magick convert "{img1}" "{img2}" -append "{img1}"')
    subprocess.run(cmd)
    os.remove(img2)

# 用 magick 将图片底部延伸，使高度扩充1倍
def convert_to_pdf(img_file):
    print(f"正在扩充:\n    {img_file}")
    cmd = shlex.split(
        f'magick "{img_file}" -gravity north -extent %wx%[fx:h*2] "{img_file}"')
    subprocess.run(cmd)

# 遍历文件夹，返回该文件夹下的所有 JPG 文件
def list_jpg_files(dir_path):
    jpg_files = []
    for root, dirs, files in os.walk(dir_path):
        for file in files:
            if file.lower().endswith('.jpg'):
                jpg_files.append(os.path.join(root, file))
    return jpg_files

# 得到两两成对的 JPG 文件
def get_pair(jpg_files:list):
    cnt = 0
    pair_list = []
    for i in range(0, len(jpg_files) - 1, 2):
        up_pic = jpg_files.pop(0)
        down_pic = jpg_files.pop(0)
        pair_list.append([up_pic, down_pic])
    return pair_list

# 主函数
def main():

    dir_path = sys.argv[1]
    jpg_files = list_jpg_files(dir_path)
    pair_list = get_pair(jpg_files)

    # 多进程拼接
    with Pool(processes=8) as pool:
        pool.map(append_images, pair_list)
    
    if jpg_files:
        convert_to_pdf(jpg_files[0])


if __name__ == '__main__':
    main()
    input("按下回车键退出...")
