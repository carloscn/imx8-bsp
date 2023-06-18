# !/bin/bash

source build.cfgimx-uuc

if [ ! -d "imx-uuc" ]; then
	echo "[INFO] imx-uuc does not exist, Downloading imx-uuc..."
    git clone https://github.com/nxp-imx/imx-uuc.git --depth=1
fi
if [ $? -eq 0 ]; then
    echo "[INFO] Pull imx-uuc done!"
else
    echo "[ERR] Pull imx-uuc failed."
    exit -1
fi

pushd imx-uuc
make clean
make
popd

echo "[INFO] Build imx-uuc done!"