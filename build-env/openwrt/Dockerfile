# This is a comment
FROM ubuntu:12.04
MAINTAINER  erwin<m9207216@gmail.com>

#
RUN apt-get update
RUN apt-get -y install \
	build-essential \
	git \
	openssh-server \
	make \
	libncurses5-dev \
	zlib1g-dev gawk flex gettext wget unzip python 
		
RUN apt-get autoclean
RUN apt-get clean
RUN apt-get autoremove

#
RUN echo 'root:docker' | chpasswd

# Setting openssh
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
