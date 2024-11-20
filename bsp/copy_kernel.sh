#!/bin/bash

source build.cfg

DTB_FILE=imx8mq-evk-root.dtb

if [ ! -d "${UDISK}/BOOT/" ]; then
    echo "[ERROR] Directory ${UDISK}/BOOT/ does not exist. Exiting."
    exit 1
fi

echo "[INFO] Copying kernel..."

# Kernel backup if exists
if [ -f "${UDISK}/BOOT/Image" ]; then
    echo "[INFO] Backing up existing kernel..."
    sudo cp -v "${UDISK}/BOOT/Image" "Image.bak_$(date +%Y%m%d%H%M%S)"
fi

sudo cp -v linux-imx/arch/arm64/boot/Image "${UDISK}/BOOT/"
if [ $? -eq 0 ]; then
    echo "[INFO] Kernel copied successfully!"
else
    echo "[ERROR] Failed to copy the kernel."
    exit 1
fi

echo "[INFO] Copying device tree..."

# Device tree backup if exists
if [ -f "${UDISK}/BOOT/${DTB_FILE}" ]; then
    echo "[INFO] Backing up existing device tree..."
    sudo cp -v "${UDISK}/BOOT/${DTB_FILE}" "${DTB_FILE}.bak_$(date +%Y%m%d%H%M%S)"
fi

sudo cp -v "linux-imx/arch/arm64/boot/dts/freescale/${DTB_FILE}" "${UDISK}/BOOT/"
if [ $? -eq 0 ]; then
    echo "[INFO] Device tree copied successfully!"
else
    echo "[ERROR] Failed to copy the device tree."
    exit 1
fi

sync