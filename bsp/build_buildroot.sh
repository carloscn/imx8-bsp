# !/bin/bash

source build.cfg

if [ ! -d "buildroot" ]; then
	echo "[INFO] buildroot does not exist, Downloading buildroot..."
    git clone ${BUILDROOT_REPO} -b ${BUILDROOT_BRANCH} --depth=1 buildroot
fi
if [ $? -eq 0 ]; then
    echo "[INFO] Pull buildroot done!"
else
    echo "[ERR] Pull buildroot failed."
    exit -1
fi

pushd buildroot
make freescale_imx8mqevk_defconfig
make CROSS_COMPILE=${CROSS_COMPILE} ARCH=arm64 -j16
popd

echo "[INFO] Build buildroot done!"
