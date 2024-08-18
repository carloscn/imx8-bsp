#!/bin/bash

# Function: log messages
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Function: check command return status
utils_check_ret() {
    if [ $1 -eq 0 ]; then
        log "[INFO] $2 done!"
    else
        log "[ERR] Failed on $2!"
        exit -1
    fi
}

cp -rfv docker_build_yocto.sh yocto/

# Run container
log "Starting to run the container"
docker run \
    --cap-add NET_ADMIN \
    --hostname buildserver \
    -it \
    -v ${PWD}/yocto:/home/build/yocto \
    myd_imx8_yoctocontainer
utils_check_ret $? "Container run"
