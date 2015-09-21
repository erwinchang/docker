## Docker Desktop

 此docker desktop使用[rogaha/docker-desktop][1]的Dockerfile建立

### Ubuntu 14.04 docker version

 - 記得更新node到新版的，參考[Ubuntu 系列安裝 Docker][2]說明，更新方式如下

```
url -sSL https://get.docker.com/ubuntu/ | sudo sh
```

 - 更新後版本訊息如下

```
$ sudo docker version
Client version: 1.7.1
Client API version: 1.19
Go version (client): go1.4.2
Git commit (client): 786b29d
OS/Arch (client): linux/amd64
Server version: 1.7.1
Server API version: 1.19
Go version (server): go1.4.2
Git commit (server): 786b29d
OS/Arch (server): linux/amd64
```

### 使用docker-destktp方式
 
 - 執行docker iamges (docker run -d -p erwinchang/docker-desktop)
   指定port方式：docker run -d -p 3333:22 erwinchang/docker-desktop

 - 開啟docker images port 22 (docker port xx_id 22)
 - 登入產生帳號及取得密碼( docker logs xx_id | sed -n 1p )

```
$ sudo docker run -d -P erwinchang/docker-desktop
600aafef158bf1b3c2b49f5224f88cdb018d7f7df4f0cc0a5de8995035c7c38e

$ sudo docker ps -a
CONTAINER ID        IMAGE                       COMMAND                CREATED             STATUS              PORTS                   NAMES
600aafef158b        erwinchang/docker-desktop   "/bin/bash /src/star   58 seconds ago      Up 58 seconds       0.0.0.0:32769->22/tcp   high_einstein       

$ sudo docker port 600aafef158b 22
0.0.0.0:32769

$ sudo docker logs 600aafef158b | sed -n 1p
[sudo] password for erwin: 
User: docker Password: ohRai4bohfie

```
 
 - 開啟新的session
 - 使用XPRA遠端登入

```
ssh docker@192.168.22.50 -p 32769 "sh -c './docker-desktop -s 800x600 -d 10 > /dev/null 2>&1 &'"
xpra --ssh="ssh -p 32769" attach ssh:docker@192.168.22.50:10
```

### 關於docker image開啟xpra server方式
 
 當開啟新的session，即登入執刪docker-desktop script
 ex. 登入docker，使用./docker-desktop -s 1920x1080 -d 11

```
 xpra start :$DISPLAY & sleep 5; 
 xpra stop :$DISPLAY & sleep 5; 
 xpra start :$DISPLAY --start-child="Xephyr -ac -screen $SCREEN_SIZE -query localhost -host-cursor -reset -terminate :$DISPLAY_1" 
                      --xvfb="Xvfb +extension Composite -screen 0 ${SCREEN_SIZE}x24+32 -nolisten tcp -noreset -auth /home/docker/.Xauthority" & sleep 5 
; DISPLAY=:$DISPLAY_1 fluxbox & DISPLAY=:$DISPLAY_1 rox --pinboard=Default &
```

```
docker@600aafef158b:~$ ps -ef | grep xpra
docker     486     1  1 05:10 ?        00:00:22 /usr/bin/python /usr/bin/xpra start :11 --start-child=Xephyr -ac -screen 1920x1080 -query localhost -host-cursor -reset -terminate :12 --xvfb=Xvfb +extension Composite -screen 0 1920x1080x24+32 -nolisten tcp -noreset -auth /home/docker/.Xauthority
docker     762   761  0 05:33 ?        00:00:00 /usr/bin/python /usr/bin/xpra _proxy :11
```


### 其它說明
 
  - [基于 ssh + Xpra 构建 Docker 桌面系统][3]
  - [xpra][4]
  - [xpra on the Raspberry Pi][5]

[1]:https://github.com/rogaha/docker-desktop
[2]:https://philipzheng.gitbooks.io/docker_practice/content/install/ubuntu.html
[3]:http://www.tinylab.org/based-on-ssh-build-docker-xpra-desktop/
[4]:http://muxueqz.gitcafe.io/xpra.html
[5]:http://blog.spiralofhope.com/3179-xpra-on-the-raspberry-pi.html