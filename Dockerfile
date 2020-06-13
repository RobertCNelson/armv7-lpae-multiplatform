#!/bin/echo docker build . -f
# -*- coding: utf-8 -*-

FROM debian:10

RUN echo "# log: Setup system" \
  && set -x \
  && apt-get update \
  && apt-get install -y \
    bc \
    bison \
    build-essential \
    cpio \
    fakeroot \
    flex \
    gettext \
    git \
    libmpc-dev \
    libncurses5-dev \
    libssl-dev  \
    lsb-release \
    lzma \
    lzop \
    make \
    man-db \
    myrepos\
    pkg-config \
    u-boot-tools \
    wget \
    rsync \
    kmod \
  && sync
  
ENV project armv7-lpae-multiplatform
ENV workdir /usr/local/opt/${project}/src/${project}
ADD . ${workdir}
WORKDIR ${workdir}

RUN echo "# log: Building ${project}" \
  && set -x \
  && sh -x ./build_deb.sh \ 
  && find deploy/ \
  && sync
