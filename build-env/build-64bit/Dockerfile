FROM ubuntu:14.04

MAINTAINER Erwin "m9207216@gmail.com"

RUN apt-get update
RUN apt-get -y install \
        build-essential \
        git \
        openssh-server \
        make
RUN apt-get autoclean
RUN apt-get clean
RUN apt-get autoremove


RUN mkdir /var/run/sshd
RUN echo 'root:docker' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
