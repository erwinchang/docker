# This is a comment
FROM erwinchang/ubuntu-12.04-32bit
MAINTAINER  erwin<m9207216@gmail.com>

#
#RUN linux32 sed -i 's/archive.ubuntu.com/tw.archive.ubuntu.com/g' /etc/apt/sources.list
RUN linux32 sed -i 's/archive.ubuntu.com/ubuntu.stu.edu.tw/g' /etc/apt/sources.list
RUN linux32 apt-get update -y
RUN linux32 apt-get -y install \
	build-essential \
	openssh-server \
	git-core \
	make \
	lua5.1 \
	liblua5.1-0.dev \
	libncurses-dev \
	uboot-mkimage \
	automake \
	cmake \
    curl \
    bc \
    mtd-utils

#make kernel need package : uboot-mkimage, libncurses-dev
#make rootfs need package : lzma
#libuv : automake
#make hisi3536 kernel need package : bc
#make hisi3536 host tools : mtd-utils
#
#node.js
#curl
RUN linux32 curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
RUN linux32 apt-get -y install nodejs
RUN linux32 npm install -g gulp

# fix LC_ALL
RUN linux32 locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Cleaning
RUN linux32 apt-get autoclean
RUN linux32 apt-get clean
RUN linux32 apt-get autoremove

 #use bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
