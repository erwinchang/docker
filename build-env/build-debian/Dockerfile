FROM debian:wheezy

#https://blog.codeship.com/using-docker-build-debian-packages/
#https://www.debian.org/doc/manuals/maint-guide/start.zh-tw.html#needprogs

ENV DEBIAN_FRONTEND noninteractive 
RUN apt-get update && apt-get install -y \ 
    build-essential \ 
    make \
    dh-make
