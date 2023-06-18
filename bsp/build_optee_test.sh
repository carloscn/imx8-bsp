# !/bin/bash

source build.cfg

if [ ! -d "imx-optee-test" ]; then
	echo "[INFO] imx-optee-os does not exist, Downloading imx-optee-test..."
    git clone https://github.com/nxp-imx/imx-optee-test.git -b ${OPTEE_OS_BRANCH} --depth=1
fi

if [ $? -eq 0 ]; then
    echo "[INFO] Pull imx-optee-test done!"
else
    echo "[ERR] Pull imx-optee-test failed."
    exit -1
fi

pushd imx-optee-test

popd

echo "[INFO] Build imx-optee-test done!"