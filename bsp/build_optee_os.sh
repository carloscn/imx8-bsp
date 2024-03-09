# !/bin/bash

source build.cfg

if [ ! -d "imx-optee-os" ]; then
	echo "[INFO] imx-optee-os does not exist, Downloading imx-optee-os..."
    git clone https://github.com/nxp-imx/imx-optee-os.git -b ${OPTEE_OS_BRANCH} --depth=1
fi
if [ $? -eq 0 ]; then
    echo "[INFO] Pull imx-optee-os done!"
else
    echo "[ERR] Pull imx-optee-os failed."
    exit -1
fi

pushd imx-optee-os
export CROSS_COMPILE64=${CROSS_COMPILE}
bash ./scripts/nxp_build.sh imx-mx8mqevk
popd

echo "[INFO] Build imx-optee-os done!"