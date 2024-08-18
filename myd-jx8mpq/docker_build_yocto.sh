# !/bin/bash

sudo chown -R build:build sources
sudo chown -R build:build downloads
sudo chmod a+rwx build:build downloads
git config --global --add safe.directory '*'

source setup-environment

EULA=1 DISTRO=fsl-imx-xwayland MACHINE=myd-jx8mp source sources/meta-myir/tools/myir-setup-release.sh -b build-xwayland
bitbake myir-image-full

