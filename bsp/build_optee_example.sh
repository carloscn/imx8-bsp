# !/bin/bash

source build.cfg

if [ ! -d "optee_examples" ]; then
	echo "[INFO] imx-optee-os does not exist, Downloading optee_examples..."
    git clone https://github.com/linaro-swg/optee_examples.git --depth=1 -b 3.5.0
fi

if [ $? -eq 0 ]; then
    echo "[INFO] Pull optee_examples done!"
else
    echo "[ERR] Pull optee_examples failed."
    exit -1
fi

export TA_DEV_KIT_DIR=${PWD}/optee-os-imx/build.mx8mqevk/export-ta_arm64
export OPTEE_CLIENT_EXPORT=${PWD}/imx-optee-client/out/export/usr

pushd optee_examples
make clean
make PLATFORM=arm \
     HOST_CROSS_COMPILE=${CROSS_COMPILE} \
     TEEC_EXPORT=${OPTEE_CLIENT_EXPORT} \
     TA_DEV_KIT_DIR=${TA_DEV_KIT_DIR} \
     -j16
popd

echo "[INFO] Build optee_examples done!"