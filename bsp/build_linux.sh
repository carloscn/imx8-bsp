# !/bin/bash

source build.cfg

if [ ! -d "linux-imx" ]; then
	echo "[INFO] linux does not exist, Downloading linux..."
    git clone https://github.com/nxp-imx/linux-imx.git -b ${LINUX_BRANCH} --depth=1
fi
if [ $? -eq 0 ]; then
    echo "[INFO] Pull linux-imx done!"
else
    echo "[ERR] Pull linux-imx failed."
    exit -1
fi

pushd linux-imx
cp -rfv configs/imx8_defconfig arch/arm64/configs/
make clean
make CROSS_COMPILE=${CROSS_COMPILE} ARCH=arm64 imx8_defconfig
make CROSS_COMPILE=${CROSS_COMPILE} ARCH=arm64 -j16
popd

echo "[INFO] Build Linux done!"