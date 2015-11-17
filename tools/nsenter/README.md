# [nsenter][1]

參考[jpetazzo/nsenter][1]建立此docker

* 使用nsenter 取代 ssh login方式
* [nsenter說明][2]

```
nsenter - run program with namespaces of other processes

 nsenter [options] [program [arguments]]

       -t, --target pid
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
