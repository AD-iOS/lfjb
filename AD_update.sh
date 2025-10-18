#!/bin/bash

# AD幫忙更新的腳本

cd /var/mobile/lfjb

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
git add .
git commit -m "Updated by AD $(date +'%Y-%m-%d %H:%M')"
# git pull --rebase
git push origin main
gh pr create