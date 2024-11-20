# !/bin/bash

source build.cfg

if [ ! -d "atf-imx" ]; then
	echo "[INFO] atf does not exist, Downloading atf..."
    git clone https://github.com/nxp-imx/imx-atf.git -b ${ATF_BRANCH} --depth=1 atf-imx
fi
if [ $? -eq 0 ]; then
    echo "[INFO] Pull atf done!"
else
    echo "[ERR] Pull atf failed."
    exit -1
fi

pushd atf-imx
make distclean
make PLAT=imx8mq bl31 -j8
popd

echo "[INFO] Build atf done!"