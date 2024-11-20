#!/bin/bash

source build.cfg

BOOT_SCR=uboot-imx/boot.scr

if [ ! -d "${UDISK}/BOOT/" ]; then
    echo "[ERROR] Directory ${UDISK}/BOOT/ does not exist. Exiting."
    exit 1
fi

echo "[INFO] Copying kernel..."

# Kernel backup if exists
if [ -f "${UDISK}/BOOT/uImage" ]; then
    echo "[INFO] Backing up existing kernel..."
    sudo cp -v "${UDISK}/BOOT/uImage" "uImage.bak_$(date +%Y%m%d%H%M%S)"
fi

sudo cp -v linux-imx/uImage "${UDISK}/BOOT/"
if [ $? -eq 0 ]; then
    echo "[INFO] Kernel copied successfully!"
else
    echo "[ERROR] Failed to copy the kernel."
    exit 1
fi

cp -rfv ${BOOT_SCR} ${UDISK}/BOOT/

sync