FROM ubuntu:14.04

RUN sed -i 's/archive.ubuntu.com/tw.archive.ubuntu.com/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install curl build-essential git

#https://gist.github.com/wangyandong-ningxia/0ba636a0448f24de4c20
#compile util-linux
RUN apt-get -y install libncurses5-dev libslang2-dev gettext zlib1g-dev libselinux1-dev debhelper lsb-release pkg-config po-debconf autoconf automake autopoint libtool

RUN mkdir /src
WORKDIR /src
RUN git clone git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git util-linux
WORKDIR /src/util-linux
RUN ./autogen.sh
RUN ./configure --without-ncurses
RUN make LDFLAGS=-all-static nsenter
RUN cp nsenter /
ADD docker-enter /docker-enter
ADD installer /installer
CMD /installer
# Now build the importenv helper
WORKDIR /src
ADD importenv.c /src/importenv.c
RUN make LDFLAGS=-static CFLAGS=-Wall importenv
RUN cp importenv /

