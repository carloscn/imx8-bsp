# !/bin/bash

# Note, the original yocto repo from https://github.com/MYiR-Dev/myir-imx-manifest
mkdir -p yocto && \
cd yocto && \
export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo/' && \
repo init -u https://github.com/carloscn/myir-imx-manifest.git --no-clone-bundle --depth=1 -m myir-i.mx8m-5.10.9-1.0.0.xml -b i.MX8M-5.10-gatesgarth-dev && \
repo sync -j8 && \
cd .. && \
chmod -R 777 yocto
echo "[INFO] yocto repo done!"
