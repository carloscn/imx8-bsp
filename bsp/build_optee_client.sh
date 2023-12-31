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

pushd imx-optee-client

popd

echo "[INFO] Build imx-optee-client done!"