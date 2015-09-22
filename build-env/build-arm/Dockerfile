# This is a comment
FROM erwinchang/ubuntu-12.04-32bit
MAINTAINER  erwin<m9207216@gmail.com>

#
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
	cmake

#make kernel need package : uboot-mkimage, libncurses-dev

#install uci
ADD uci-lib.tgz /
RUN linux32 ldconfig

RUN linux32 apt-get autoclean
RUN linux32 apt-get clean
RUN linux32 apt-get autoremove

# We use bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Setting openssh
RUN linux32 mkdir /var/run/sshd
RUN linux32 echo 'root:docker' | chpasswd
RUN linux32 sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# setting svn script
RUN linux32 echo "alias  setsvn='export SVN_DIR=\$PWD;source \$SVN_DIR/dvr_rdk/svnapp/default_bashrc'" >> /etc/profile
RUN linux32 echo "alias  setpkg='export CPKG_TOPDIR=\$PWD;source \$CPKG_TOPDIR/scripts/default_bashrc'" >> /etc/profile
RUN linux32 echo "export TOOLS_ARM_2009q1_DIR=/opt/arm-2009q1" >> /etc/profile
RUN linux32 echo "export PATH=$PATH:/opt/arm-2009q1/bin" >> /etc/profile

# add file
ADD arm-2009q1-203-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar.gz /opt
RUN linux32 mkdir -p /usr/local/Trolltech
ADD gitconfig /root/.gitconfig

ENTRYPOINT ["linux32"]
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
