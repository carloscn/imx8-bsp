# !/bin/bash

source build.cfg

if [ ! -d "uboot-imx" ]; then
	echo "[INFO] uboot does not exist, Downloading uboot..."
    git clone https://github.com/nxp-imx/uboot-imx.git -b ${UBOOT_BRANCH} --depth=1
fi

if [ $? -eq 0 ]; then
    echo "[INFO] Pull uboot-imx done!"
else
    echo "[ERR] Pull uboot-imx failed."
    exit -1
fi

pushd uboot-imx
PATCH_FILE="0001-imx8mq-bring-up-MYD-JX8MX-board.patch"
PATCH_DIR="../configs"
cp -rfv "${PATCH_DIR}/${PATCH_FILE}" .
if git apply --check "${PATCH_FILE}"; then
    echo "Applying patch: ${PATCH_FILE}"
    git apply --stat "${PATCH_FILE}"
    git am "${PATCH_FILE}"
else
    echo "Patch ${PATCH_FILE} is already applied or cannot be applied cleanly."
fi
make clean
make CROSS_COMPILE=${CROSS_COMPILE} imx8mq_evk_defconfig
make CROSS_COMPILE=${CROSS_COMPILE} -j16
if [ $? -eq 0 ]; then
    echo "[INFO] Build uboot-imx done!"
else
    echo "[ERR] Build uboot-imx failed."
    exit -1
fi
popd

echo "[INFO] Build uboot done!"