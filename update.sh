#!/bin/bash

cd /var/mobile/lfjb #可以存放到其他位置 #如果存放到其他位置這個要改絕對路徑

# 生成索引文件
dpkg-scanpackages -m . /dev/null > Packages
xz -c Packages > Packages.xz
bzip2 -c Packages > Packages.bz2

# 计算校验值
md5_pkg=$(md5sum Packages | cut -d' ' -f1)
size_pkg=$(wc -c < Packages)
md5_xz=$(md5sum Packages.xz | cut -d' ' -f1)
size_xz=$(wc -c < Packages.xz)
md5_bz2=$(md5sum Packages.bz2 | cut -d' ' -f1)
size_bz2=$(wc -c < Packages.bz2)

# 提交更新
# git add .
# git commit -m "Auto-update $(date +'%Y-%m-%d %H:%M')"
# git pull --rebase
# git push origin main