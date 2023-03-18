"""
======================================================================
先科普一下：

PDF 的长、宽，不是以像素为单位的，它也没有 DPI 的概念
PDF的长宽单位是点（point），通常缩写为pt。
1pt等于1/72英寸，也就是说PDF中的长和宽都是以1/72英寸为基准的。
而 1 英寸等于 2.54 厘米，可以得到：
    1 pt ≈ 0.035 cm
    1 cm ≈ 28.3465 pt

当一个PDF文件被输出到打印机或显示器上时，就需要考虑其分辨率。
在这种情况下，PDF文件通常会使用dpi来确定输出质量。
例如，如果一个PDF文件被输出为300dpi的图像，那么它的分辨率将根据输出的dpi进行调整。

一般正常扫描的 PDF 宽度都与实际物理文档大小相同，宽度约为是 17cm - 21cm，21cm 就已经是 A4 纸的宽度了。
但一些制作者，是先用 300dpi 扫描出了图像，编辑图像（如添加水印）后，以 72dpi 保存（但分辨率没变），
由于 png 图像无法保存 dpi，保存为 png 格式时，也会使得 dpi 变为默认的 72，
而再用 72dpi 的图像生成的 PDf，就会导致生成的 PDF 尺寸大了 300/72=4.16 倍，
17cm 宽的原文档，就会生成 70cm 宽的 PDF 文档。

如果 PDF 的页面宽度太大，例如超过了 40cm，那就是 PDF 文档的制作者犯了上述错误。
对于这种文档，如果你用 Edge 浏览器打开，会发现它的页面超级超级大，必须缩小之后才能看到整个页面。
此时，你再用 PS 打开这个页面，如果不做调整，用 300dpi 打开，就会生成超大尺寸、超大分辨率的图片。

为了能将错误大小的 PDF 调整回正常尺寸，特写此脚本。

======================================================================

拖入 PDF 文件，运行脚本后，会首先显示前 5 页的宽度。

如果页面宽度是正常大小，就可以关闭该脚本了。
如果页面宽度不正常，就进行放缩，输入一个合适的页面宽度，回车后，就会生成一个新的 pdf 文件，
这个新文档的页面宽度与设定一致。

======================================================================

这个脚本用到了 pymupdf 模块，需要用 pip installl pymupdf 安装。

======================================================================

脚本使用 New Bing 辅助生成，后续进行了一系列修改。

使用 python 语言编写一个脚本，要求是：

1. 脚本可以接收一个 pdf 文件作为参数，如果没有提供参数，则提示用户输入文件路径。
2. 脚本还会提示用户输入一个新的页面宽度，单位是 cm。
3. 脚本会使用 pymupdf 模块打开原始 pdf 文件，并根据新的页面宽度等比例缩放每一页。
4. 脚本会创建一个新的 pdf 文件，并将缩放后的页面插入到其中。
5. 脚本会将新的 pdf 文件保存到磁盘上，文件名前缀和原始文件一样，后缀加上新页面宽度（单位 cm）。

======================================================================
"""

import sys
import os
try:
    import fitz  # 导入 pymupdf 模块
except:
    input('''未能找到 pymupdf 模块，请使用 `pip install pymupdf` 安装''')

# 获取 pdf 文件参数，如果没有提供，则提示输入文件路径
if len(sys.argv) > 1:
    pdf_file = sys.argv[1]
else:
    pdf_file = input("请输入 pdf 文件的路径：").strip('"')

if not os.path.isfile(pdf_file):
    print("文件不存在：", pdf_file)
    sys.exit(1)

# 使用 pymupdf 打开原始 pdf 文件（A.pdf）
doc_a = fitz.open(pdf_file)

# 遍历前5页
print('原始页面宽度：')
for page_num in range(min(5, doc_a.page_count)):
    page = doc_a[page_num]
    media_box = page.mediabox
    width = media_box[2] - media_box[0]
    print(f"    第{page_num+1}页宽度：{width/28.35:.2f}cm")  # 1cm = 28.35pt
print('    ...\n')

# 提示输入新 pdf 的宽度，单位是 cm
new_width = float(input("请输入新 pdf 的宽度（单位：cm）："))

# 新建一个空白的 pdf 文件（B.pdf）
doc_b = fitz.open()

# 对于 A.pdf 的每一页，根据新宽度等比例缩放，并插入到 B.pdf 中
for page in doc_a:
    # 获取旧页面的宽度和高度，单位是点（1 cm = 28.35 点）
    old_width, old_height = page.rect.width, page.rect.height

    # 根据新宽度计算新高度，保持纵横比不变
    new_height = old_height * new_width / old_width

    # 在 B.pdf 中新增一页，并设置新页面的大小
    new_page = doc_b.new_page(width=new_width * 28.35,
                              height=new_height * 28.35)

    # 将 A 中的旧页面显示到 B 中的新页面上，居中对齐
    new_page.show_pdf_page(new_page.rect, doc_a, page.number)

# 将 B.pdf 保存为文件，文件名前缀和原文件一样，后面加上新文件页面的宽度（单位 cm）
new_file_name = pdf_file[:-4] + "_" + str(new_width) + "cm" + ".pdf"
doc_b.save(new_file_name)
