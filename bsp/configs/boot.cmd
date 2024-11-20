setenv bootargs console=ttymxc0,115200 earlycon root=/dev/mmcblk1p2 rootwait rw
fatload mmc ${mmcdev}:${mmcpart} 0x60000000 uImage
bootm 0x60000000