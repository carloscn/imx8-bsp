# README


## Bootloader

On i.MX 8, the U-Boot cannot boot the device by itself. The i.MX 8 pre-built images or Yocto Project default bootloader is imx-boot
for the SD card, which is created by the imx-mkimage. The imx-boot binary includes the U-boot, Arm trusted firmware, DCD
file (8QuadMax/8QuadXPlus/8DXL), system controller firmware (8QuadMax/8QuadXPlus/8DXL), SPL (8M SoC), DDR firmware
(8M), HDMI firmware (8M Quad), and SECO firmware for B0 (8QuadMax/8QuadXPlus/8DXL).

On i.MX 8M SoC, the second program loader (SPL) is enabled in U-Boot. SPL is implemented as the first-level bootloader running
on TCML (For i.MX 8M Nano and i.MX 8M Plus, the first-level bootloader runs in OCRAM). It is used to initialize DDR and load
U-Boot, U-Boot DTB, Arm trusted firmware, and TEE OS (optional) from the boot device into the memory. After SPL completes
loading the images, it jumps to the Arm trusted firmware BL31 directly. The BL31 starts the optional BL32 (TEE OS) and BL33
(U-Boot) for continue booting kernel.

In imx-boot, the SPL is packed with DDR Firmware together, so that ROM can load them into Arm Cortex-M4 TCML or OCRAM
(only for i.MX 8M Nano and i.MX 8M Plus). The U-Boot, U-Boot DTB, Arm Trusted firmware, and TEE OS (optional) are packed
into a FIT image, which is finally built into imx-boot.

## Linux Kernel

### For RAW Image

cp -rfv ${PWD}/bsp/linux-imx/arch/arm64/boot/Image ${U_DISK}/BOOT
cp -rfv ${PWD}/bsp/linux-imx/arch/arm64/boot/dts/freescale/imx8mq-evk-root.dtb ${U_DISK}/BOOT

### For FIT Image

cp -rfv linux-imx/uImage /media/haochenwei/BOOT/

`=> fatload mmc ${mmcdev}:${mmcpart} 0x80000000 uImage`
`=> bootm 0x80000000`