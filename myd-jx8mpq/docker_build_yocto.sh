# !/bin/bash


source setup-environment

EULA=1 DISTRO=fsl-imx-xwayland MACHINE=myd-jx8mp source sources/meta-myir/tools/myir-setup-release.sh -b build-xwayland
bitbake myir-image-full 
