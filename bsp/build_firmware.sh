# !/bin/bash

source build.cfg

if [ ! -f "firmware-imx-8.1.bin" ]; then
	echo "[INFO] firmware-imx-8.18.bin does not exist, Downloading firmware-imx-8.1.bin..."
	wget "http://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.1.bin"

fi
if [ $? -eq 0 ]; then
    echo "[INFO] Pull firmware-imx-8.1.bin done!"
else
    echo "[ERR] Pull firmware-imx-8.1.bin failed."
    exit -1
fi

chmod a+x firmware-imx-8.1.bin
sh ./firmware-imx-8.1.bin

echo "[INFO] Build firmware-imx-8.1.bin done!"