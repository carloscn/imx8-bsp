# !/bin/bash

source build.cfg

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

wget https://github.com/nxp-imx/mfgtools/releases/download/uuu_1.5.165/uuu
chmod +x uuu

echo "[INFO] Build mfgtools done!"