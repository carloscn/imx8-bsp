# !/bin/bash

source build.cfg

if [ ! -d "imx-optee-client" ]; then
	echo "[INFO] imx-optee-os does not exist, Downloading imx-optee-client..."
    git clone https://github.com/nxp-imx/imx-optee-client.git -b ${OPTEE_CLIENT_BRANCH} --depth=1
fi

if [ $? -eq 0 ]; then
    echo "[INFO] Pull imx-optee-client done!"
else
    echo "[ERR] Pull imx-optee-client failed."
    exit -1
fi

UTILS_OUT=${PWD}/optee-os-imx/build.mx8mqevk/export-ta_arm64
pushd imx-optee-client
make CC="${CROSS_COMPILE}gcc" CROSS_COMPILE="$CROSS_COMPILE" PLATFORM=k3 CFG_TEE_SUPP_LOG_LEVEL=2 RPMB_EMU=0 CFG_ARM64_core=y PKG_CONFIG=pkg-config
popd

echo "[INFO] Build imx-optee-client done!"