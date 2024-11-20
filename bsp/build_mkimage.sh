# !/bin/bash

source build.cfg

if [ ! -d "imx-mkimage" ]; then
	echo "[INFO] imx-mkimage does not exist, Downloading imx-mkimage..."
    git clone https://github.com/nxp-imx/imx-mkimage.git -b ${MKIMAGE_BRANCH} --depth=1
fi
if [ $? -eq 0 ]; then
    echo "[INFO] Pull imx-mkimage done!"
else
    echo "[ERR] Pull imx-mkimage failed."
    exit -1
fi

rm -rfv imx-mkimage/iMX8M/flash.bin

pushd imx-mkimage
mkdir -p iMX8M
make clean
cp -rfv ../uboot-imx/tools/mkimage                                                        ./iMX8M/mkimage_uboot && \
cp -rfv ../configs/u-boot-spl.bin                                                         ./iMX8M/              && \
cp -rfv ../uboot-imx/u-boot-nodtb.bin                                                     ./iMX8M/              && \
cp -rfv ../uboot-imx/arch/arm/dts/fsl-imx8mq-evk.dtb                                      ./iMX8M/              && \
cp -rfv ../atf-imx/build/imx8mq/release/bl31.bin                                          ./iMX8M/              && \
cp -rfv ../optee-os-imx/build.mx8mqevk/tee.bin                                            ./iMX8M/              && \
cp -rfv ../configs/lpddr4_pmu_train_*.bin                                                 ./iMX8M/              && \
cp -rfv ../configs/signed_hdmi_imx8m.bin                                                  ./iMX8M/              && \
cp -rfv ../configs/signed_dp_imx8m.bin                                                    ./iMX8M/
if [ $? -ne 0 ]; then
    echo "[ERR] Copy binary failed."
    exit -1
fi
make SOC=iMX8MQ flash_evk_no_hdmi
if [ $? -ne 0 ]; then
    echo "[ERR] make failed."
    exit -1
fi
md5sum iMX8M/flash.bin
popd

cp -rfv imx-mkimage/iMX8M/flash.bin ./
#./uuu -b sd flash.bin
md5sum flash.bin

echo "[INFO] Build imx-mkimage done!"