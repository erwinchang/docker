FROM ubuntu:14.04

MAINTAINER Erwin "m9207216@gmail.com"

#RUN linux32 sed -i 's/archive.ubuntu.com/tw.archive.ubuntu.com/g' /etc/apt/sources.list
RUN linux32 sed -i 's/archive.ubuntu.com/ubuntu.stu.edu.tw/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install \
        build-essential \
        git \
        make \
        cmake

RUN apt-get autoclean
RUN apt-get clean
RUN apt-get autoremove

#bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN echo "cd \$DK_MOUNT_PATH" >> /root/.bashrc

ENV HOME  /root
