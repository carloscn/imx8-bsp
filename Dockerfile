FROM ubuntu:18.04
MAINTAINER Carlos Wei <calos.wei.hk@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak

RUN \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://security.ubuntu.com/ubuntu/ bionic-security main restricted universe multiverse" >> /etc/apt/sources.list

RUN apt update 
RUN apt install -y apt-transport-https ca-certificates curl sudo vim python rsync \
    tofrodos iproute2 gawk xvfb gcc git make net-tools libncurses5-dev zsh \
    tftpd zlib1g-dev flex bison libselinux1 gnupg wget diffstat chrpath socat cpio \
    autoconf libtool tar texinfo gcc-multilib build-essential libsdl1.2-dev libglib2.0-dev \
    pax gzip cmake android-tools-adb android-tools-fastboot python3-pyelftools \
    automake bc ccache codespell cscope device-tree-compiler python3-pip \
    expect ftp-upload gdisk libattr1-dev libcap-dev libfdt-dev libftdi-dev libglib2.0-dev \
    libgmp-dev libhidapi-dev libmpc-dev libpixman-1-dev libssl-dev mtools \
    netcat ninja-build unzip uuid-dev xdg-utils xz-utils lzop python3-pycryptodome \
    proxychains libgsettings-qt1 xinetd xclip libncursesw5 locales u-boot-tools

RUN mkdir -p /opt/cross-compile
RUN zsh -c "$(curl -fsSL https://raw.githubusercontent.com/carloscn/script/master/down_tool_chains/down_toolchain_linaro_7.5.0.sh)"
RUN rm -rfv *.tar.xz

RUN curl https://mirrors.tuna.tsinghua.edu.cn/git/git-repo > /bin/repo && chmod a+x /bin/repo
RUN sed -i "1s/python/python3/" /bin/repo

RUN groupadd build -g 1000
RUN useradd -ms /bin/bash -p build build -u 1028 -g 1000 && \
        usermod -aG sudo build && \
        echo "build:build" | chpasswd
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
        locale-gen
ENV LANG en_US.utf8
USER build
WORKDIR /home/build

RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" || false

RUN  git config --global --add safe.directory /home/build/bsp/uboot-imx && \
     git config --global --add safe.directory /home/build/bsp/imx-mkimage && \
     git config --global --add safe.directory /home/build/bsp/atf-imx && \
     git config --global --add safe.directory /home/build/bsp/imx-optee-client && \
     git config --global --add safe.directory /home/build/bsp/imx-optee-test && \
     git config --global --add safe.directory /home/build/bsp/optee_examples && \
     git config --global --add safe.directory /home/build/bsp/linux-imx

RUN git config --global user.email "carlos.wei.hk@gmail.com" && git config --global user.name "Carlos Wei"
