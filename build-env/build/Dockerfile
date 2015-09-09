# This is a comment
FROM erwinchang/ubuntu-12.04-32bit
MAINTAINER  erwin<m9207216@gmail.com>

#
RUN linux32 apt-get update
RUN linux32 apt-get -y install \
	build-essential \
	git \
	openssh-server \
	make
RUN linux32 apt-get autoclean
RUN linux32 apt-get clean
RUN linux32 apt-get autoremove

# Setting openssh
RUN linux32 mkdir /var/run/sshd
RUN linux32 echo 'root:docker' | chpasswd
RUN linux32 sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# setting svn script
RUN linux32 echo "alias  setsvn='export SVN_DIR=\$PWD;source \$SVN_DIR/dvr_rdk/svnapp/default_bashrc'" >> /etc/profile
RUN linux32 echo "alias  setpkg='export CPKG_TOPDIR=\$PWD;source \$CPKG_TOPDIR/scripts/default_bashrc'" >> /etc/profile

ENTRYPOINT ["linux32"]
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
