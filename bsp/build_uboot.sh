# !/bin/bash

source build.cfg

if [ ! -d "uboot-imx" ]; then
	echo "[INFO] uboot does not exist, Downloading uboot..."
    git clone https://github.com/carloscn/myir-imx8mx-uboot -b ${UBOOT_BRANCH} --depth=1 uboot-imx
fi

if [ $? -eq 0 ]; then
    echo "[INFO] Pull uboot-imx done!"
else
    echo "[ERR] Pull uboot-imx failed."
    exit -1
fi

pushd uboot-imx
git checkout include/configs/imx8mq_evk.h
cp -rfv ../configs/0001-uboot-fixed-uImage-large-size-limitation.patch .
git apply 0001-uboot-fixed-uImage-large-size-limitation.patch
make clean
make CROSS_COMPILE=${CROSS_COMPILE} imx8mq_evk_defconfig
make CROSS_COMPILE=${CROSS_COMPILE} -j16
if [ $? -eq 0 ]; then
    echo "[INFO] Build uboot-imx done!"
else
    echo "[ERR] Build uboot-imx failed."
    exit -1
fi

cp -rfv ../configs/boot.cmd .
./tools/mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n "Boot Script" -d boot.cmd boot.scr

popd

echo "[INFO] Build uboot done!"
