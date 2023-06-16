# !/bin/bash

source build.cfg

if [ ! -d "linux-imx" ]; then
	echo "[INFO] linux does not exist, Downloading linux..."
    git clone https://github.com/nxp-imx/linux-imx.git -b imx_5.4.70_2.3.0
fi
if [ $? -eq 0 ]; then
    echo "[INFO] Pull linux-imx done!"
else
    echo "[ERR] Pull linux-imx failed."
    exit -1
fi

pushd linux-imx
make clean
make CROSS_COMPILE=${CROSS_COMPILE} ARCH=arm64 imx_v8_defconfig
make CROSS_COMPILE=${CROSS_COMPILE} ARCH=arm64 -j16
popd

echo "[INFO] Build Linux done!"