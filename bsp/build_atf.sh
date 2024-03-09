# !/bin/bash

source build.cfg

if [ ! -d "imx-atf" ]; then
	echo "[INFO] atf does not exist, Downloading atf..."
    git clone https://github.com/nxp-imx/imx-atf.git -b ${ATF_BRANCH} --depth=1
fi
if [ $? -eq 0 ]; then
    echo "[INFO] Pull atf done!"
else
    echo "[ERR] Pull atf failed."
    exit -1
fi

pushd imx-atf
make distclean
make PLAT=imx8qm bl31
popd

echo "[INFO] Build atf done!"