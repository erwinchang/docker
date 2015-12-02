# Build Code基本image

## docker image 使用方式

- 執行 ./run.sh 來產生docker image及進入
- 使用 ./run.sh stop，來停止docker image


## build 使用方式

- 先使用 sudo docker pull [erwinchang/openwrt-build-env][1]
- 此為主要build openwrt使用，請使用run.sh來帶images
- 參考[openwrt build][2]

```
mkdir ~/openwrt
cd ~/openwrt
svn co svn://svn.openwrt.org/openwrt/trunk/
cd trunk

./scripts/feeds update -a
./scripts/feeds install -a

make menuconfig
make -j 3
```

## 其它說明

- docker image會自動將使用者目錄mount到docker image /opt/Docker-xxx

 
[1]:https://hub.docker.com/
[2]:http://wiki.openwrt.org/zh-tw/doc/howto/buildroot.exigence

