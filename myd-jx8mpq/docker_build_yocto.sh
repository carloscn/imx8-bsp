# !/bin/bash

EULA=1 DISTRO=fsl-imx-xwayland MACHINE=myd-jx8mp source sources/meta-myir/tools/myir-setup-release.sh -b build-xwayland
bitbake core-image-minimal