# !/bin/bash

source build.cfg

BOOT_DEV=/dev/sdb
IMAGE_NAME=flash.bin

if [ ! -e "${BOOT_DEV}" ]; then
    echo "[ERROR] Dev ${BOOT_DEV} does not exist. Exiting."
    exit 1
fi

if [ ! -f "${IMAGE_NAME}" ]; then
    echo "[ERROR] File ${IMAGE_NAME} does not exist. Exiting."
    exit 1
fi

echo "[INFO] Backing up 4M data from ${BOOT_DEV}..."
#sudo dd if=/dev/sdb of="imx_sd_bootable_image_$(date +%Y%m%d%H%M%S)" bs=1k skip=32 count=4096 && sync
# You can recover by $ sudo dd if=imx_sd_bootable_image_xxxxx of=/dev/sdb seek=32 bs=1k

echo "[INFO] Burn boot image..."
sudo dd if=${IMAGE_NAME} of=${BOOT_DEV} bs=1k seek=33 && sync
if [ $? -eq 0 ]; then
    echo "[INFO] bootable image flash successfully!"
else
    echo "[ERROR] Failed to flash bootable image."
    exit 1
fi

sync