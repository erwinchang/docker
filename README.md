# Docker Image Create
產生基本的docker image

## ubuntu12.04-i386

 基本的 32bit ubuntu 12.04 image
 同時同步到 dock-hub的[ubuntu-12.04-32bit][1]

 直接使用方式

 ```
 sudo docker pull erwinchang/ubuntu-12.04-32bit
 ```


## 開發需要docker image

 - build-env 參考ubuntu-12.04-32bit，安裝基本套件，產生[ubuntu-12.04-32bit-build][2]

 - 直接使用方式

 ```
 sudo docker pull erwinchang/ubuntu-12.04-32bit-build
 ```

## Tools

### nsenter

referece: https://github.com/jpetazzo/nsenter

```
$ git log
commit 71802a136a01704a1b8bd93d9a6608cd19359915
Merge: 25c459291859 1534951a4c9f
Author: Jerome Petazzoni <jerome.petazzoni@gmail.com>
Date:   Mon Oct 19 18:28:44 2015 -0700

    Merge branch 'BWITS-feature/#76'
```    


 [1]:https://hub.docker.com/r/erwinchang/ubuntu-12.04-32bit/
 [2]:https://hub.docker.com/r/erwinchang/ubuntu-12.04-32bit-build/
