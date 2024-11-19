# !/bin/bash

source build.cfg

if [ ! -d "uboot-imx" ]; then
	echo "[INFO] uboot does not exist, Downloading uboot..."
    git clone https://github.com/MYiR-Dev/myir-imx-uboot -b ${UBOOT_BRANCH} --depth=1 uboot-imx
fi

if [ $? -eq 0 ]; then
    echo "[INFO] Pull uboot-imx done!"
else
    echo "[ERR] Pull uboot-imx failed."
    exit -1
fi

pushd uboot-imx
cp -rfv ../configs/lpddr4* .
make clean
make CROSS_COMPILE=${CROSS_COMPILE} myd_jx8mp_2g_defconfig
make CROSS_COMPILE=${CROSS_COMPILE} -j16
if [ $? -eq 0 ]; then
    echo "[INFO] Build uboot-imx done!"
else
    echo "[ERR] Build uboot-imx failed."
    exit -1
fi
popd

echo "[INFO] Build uboot done!"
