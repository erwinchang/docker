# This is a comment
FROM ubuntu:12.04
MAINTAINER  erwin<m9207216@gmail.com>

#
#RUN linux32 sed -i 's/archive.ubuntu.com/tw.archive.ubuntu.com/g' /etc/apt/sources.list
RUN linux32 sed -i 's/archive.ubuntu.com/ubuntu.stu.edu.tw/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install \
	build-essential \
	git \
	make \
	libncurses5-dev \
	zlib1g-dev gawk flex gettext wget unzip python 
		
RUN apt-get autoclean
RUN apt-get clean
RUN apt-get autoremove

RUN linux32 echo "cd \$DK_MOUNT_PATH" >> /root/.bashrc
ENV HOME  /root
#
