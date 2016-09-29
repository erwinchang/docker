# This is a comment
FROM erwinchang/ubuntu-12.04-32bit-base
MAINTAINER  erwin<m9207216@gmail.com>

# install uci
ADD uci-lib.tgz /
RUN linux32 ldconfig

#setting env
RUN linux32 echo "alias  setsvn='export SVN_DIR=\$PWD;source \$SVN_DIR/dvr_rdk/svnapp/default_bashrc'" >> /root/.bashrc
RUN linux32 echo "cd \$DK_MOUNT_PATH" >> /root/.bashrc
ENV HOME  /root

#add file
ADD gitconfig /root/.gitconfig
