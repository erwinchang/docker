# [nsenter][1]

參考[jpetazzo/nsenter][1]建立此docker

* 使用nsenter 取代 ssh login方式
* [nsenter說明][2]
* 使用nsenter登入或操作真方便

```
nsenter - run program with namespaces of other processes

 nsenter [options] [program [arguments]]

       -t, --target pid
```

## 如何使用docker-enter

* docker-enter說明

```
$ docker-enter
Usage: docker-enter CONTAINER [COMMAND [ARG]...]

Enters the Docker CONTAINER and executes the specified COMMAND.
If COMMAND is not specified, runs an interactive shell in CONTAINER.
e
```

### 執行指令
	* 先取得container id
	* 使用docker-enter id 指令 (代入id或另名皆可)

```
$ sudo docker ps -a
CONTAINER ID        IMAGE                     COMMAND                CREATED        STATUS              PORTS                  NAMES
811ad84eaef3        erwinchang/build-hiv200   "linux32 /usr/sbin/s   6 minutes ago  Up 6 minutes xx DOCKER-erwin-build-hiv200

$ sudo docker-enter 811ad84eaef3 ls -la /opt
total 16
drwxr-xr-x  4 root root 4096 Nov 17 17:17 .
drwxr-xr-x 66 root root 4096 Nov 17 17:17 ..
drwxr-xr-x 60 1000 1000 4096 Nov 17 16:58 DOCKER-erwin-build-hiv200
drwxr-xr-x  8 1000 1000 4096 Nov 27  2014 arm-hisiv200-linux

erwin@erwin-homepc: /media/raid5/data/game/github/docker on master
$ sudo docker-enter DOCKER-erwin-build-hiv200 ls -la /opt
total 16
drwxr-xr-x  4 root root 4096 Nov 17 17:17 .
drwxr-xr-x 66 root root 4096 Nov 17 17:17 ..
drwxr-xr-x 60 1000 1000 4096 Nov 17 16:58 DOCKER-erwin-build-hiv200
drwxr-xr-x  8 1000 1000 4096 Nov 27  2014 arm-hisiv200-linux
```

### 登入docker

* docker-enter id/name：則直接登入

```
erwin@erwin-homepc: /media/raid5/data/game/github/docker on master
$ sudo docker-enter DOCKER-erwin-build-hiv200
root@811ad84eaef3:/# ls -l /opt/
total 8
drwxr-xr-x 60 1000 1000 4096 Nov 17 16:58 DOCKER-erwin-build-hiv200
drwxr-xr-x  8 1000 1000 4096 Nov 27  2014 arm-hisiv200-linux
```


## 安裝nsenter方式

### 方式一：直接使用prebuild

*若為ubuntu 14.04 64bin，直接將prebuild/nsenter,docker-enter,importenv

### 方式二：由docker產生

* 將會由.c產生 Ubuntu 14.04 64bit binary
* 執行docker將會產生nsenter /docker-enter /importenv
* 再將這3個copy到/usr/local/bin

```
erwin@erwin-homepc: /media/raid5/data/game/github/docker/tools/nsenter on master [!]
$ sudo docker run --rm -v /tmp/dd:/target erwinchang/nsenter
Installing nsenter to /target
Installing docker-enter to /target
Installing importenv to /target
$ ls -rtld /tmp/dd
drwxrwxr-x 2 erwin erwin 100 Nov 18 01:00 /tmp/dd
erwin@erwin-homepc: /media/raid5/data/game/github/docker/tools/nsenter on master [!]
$ ls -rtl /tmp/dd
total 1816
-rwxr-xr-x 1 root root 967435 Nov 18 01:00 nsenter
-rwxr-xr-x 1 root root   1533 Nov 18 01:00 docker-enter
-rwxr-xr-x 1 root root 881791 Nov 18 01:00 importenv
```

[1]:https://github.com/jpetazzo/nsenter
[2]:http://man7.org/linux/man-pages/man1/nsenter.1.html
