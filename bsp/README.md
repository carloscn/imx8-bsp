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

| **File Name**                    | **Description** |
|----------------------------------|-----------------|
| **scfw_tcm.bin**                 | System Controller Firmware binary for the target board |
| **mx8qm(qx)-ahab-container.image** | Security Controller Firmware for the QM or QXP variants |
| **bl31.bin**                     | ARM Trusted Firmware binary. Required if using u-boot with ATF. Only needed to create Cortex-A image with u-boot. |
| **u-boot.bin**                   | U-boot binary (optional) |
| **m4_image**                     | M4 binary image. The QM variant has 2 Cortex-M4s and in this case, two M4 binaries might be required (optional) |


https://sources.buildroot.net/firmware-imx/
wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/imx-seco-3.8.5.bin
http://sources.buildroot.net/imx-sc-firmware/

## Linux Kernel

### For RAW Image

cp -rfv ${PWD}/bsp/linux-imx/arch/arm64/boot/Image ${U_DISK}/BOOT

cp -rfv ${PWD}/bsp/linux-imx/arch/arm64/boot/dts/freescale/imx8mq-evk-root.dtb ${U_DISK}/BOOT

### For FIT Image

cp -rfv linux-imx/uImage /media/haochenwei/BOOT/

`=> setenv fdt_file imx8mq-evk-root.dtb`

`=> fatload mmc ${mmcdev}:${mmcpart} 0x60000000 uImage`

`=> bootm 0x60000000`