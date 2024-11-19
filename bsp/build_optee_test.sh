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
export TA_DEV_KIT_DIR=${PWD}/optee-os-imx/build.mx8mqevk/export-ta_arm64
export OPTEE_CLIENT_EXPORT=${PWD}/imx-optee-client/out/export/usr
export OPENSSL_EXPORT=${PWD}/openssl/out

pushd imx-optee-test
make clean
make ARCH=arm64 CC="${CROSS_COMPILE}gcc -L${OPENSSL_EXPORT}/lib -I${OPENSSL_EXPORT}/include " -j16
popd

echo "[INFO] Build imx-optee-test done!"