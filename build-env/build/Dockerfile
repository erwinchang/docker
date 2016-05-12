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
	cmake

#make kernel need package : uboot-mkimage, libncurses-dev
#make rootfs need package : lzma
#libuv : automake

# install uci
ADD uci-lib.tgz /
RUN linux32 ldconfig

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

#setting env
RUN linux32 echo "alias  setsvn='export SVN_DIR=\$PWD;source \$SVN_DIR/dvr_rdk/svnapp/default_bashrc'" >> /root/.bashrc
RUN linux32 echo "cd \$DK_MOUNT_PATH" >> /root/.bashrc
ENV HOME  /root

#add file
ADD gitconfig /root/.gitconfig
