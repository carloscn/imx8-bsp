# !/bin/bash

source build.cfg

if [ ! -f "firmware-imx-8.1.bin" ]; then
	echo "[INFO] firmware-imx-8.18.bin does not exist, Downloading firmware-imx-8.1.bin..."
	wget "http://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.1.bin"
    wget "https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/imx-scfw-porting-kit-1.7.4.bin"
fi
if [ $? -eq 0 ]; then
    echo "[INFO] Pull firmware-imx-8.1.bin done!"
else
    echo "[ERR] Pull firmware-imx-8.1.bin failed."
    exit -1
fi

chmod a+x firmware-imx-8.1.bin
sh ./firmware-imx-8.1.bin --auto-accept

chmod a+x imx-scfw-porting-kit-1.7.4.bin
sh ./firmware-imx-8.1.bin --auto-accept

pushd imx-scfw-porting-kit-1.7.4/src && tar -xvf scfw_export_mx8qm_b0.tar.gz && \
    pushd scfw_export_mx8qm_b0 && \
        make clean && \
        export ARCH=arm && export CROSS_COMPILE=${CM_CROSS_COMPILE} && make qm B=mek R=B0 && \
        ls build_mx8qm_b0/scfw_tcm.bin && \
    popd && \
popd



echo "[INFO] Build firmware-imx-8.1.bin done!"