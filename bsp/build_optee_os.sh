# !/bin/bash

source build.cfg

if [ ! -d "optee-os-imx" ]; then
	echo "[INFO] optee-os-imx does not exist, Downloading optee-os-imx..."
    git clone https://github.com/nxp-imx/imx-optee-os.git -b ${OPTEE_OS_BRANCH} --depth=1 optee-os-imx
fi
if [ $? -eq 0 ]; then
    echo "[INFO] Pull optee-os-imx done!"
else
    echo "[ERR] Pull optee-os-imx failed."
    exit -1
fi

pushd optee-os-imx
export CROSS_COMPILE64=${CROSS_COMPILE}
bash ./scripts/nxp_build.sh mx8mqevk
popd

echo "[INFO] Build optee-os-imx done!"