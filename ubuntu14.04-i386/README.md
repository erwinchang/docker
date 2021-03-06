# Ubuntu 14.04 build
產生基本的docker使用14.04 image，參考[toopher][1]方式建立

## Docker
 
 - 下載github之後，執行下例指令即可使用目前的ubuntu14.04.tar.gz建立新的docker image

```
sudo docker build -t erwinchang/ubuntu-14.04-32bit .
```

## 產生rootfs tag方式
 
 - 記得先安裝 sudo apt-get install VirtualBox
 - 若無法正常開啟(vagrant up)，手動更改VirtualBox設定，關閉硬体加速即可
 - 使用vagrant ssh，登入vm
 - 執行make-docker-image.sh，產生ubuntu12.04.tar.gz
 - 不需在執行vagrant init ，本目錄已有Vagrantfile檔案 (config.vm.box = "ubuntu/trusty32")

```
vagrant up
vagrant ssh
cd /vagrant
sudo ./make-docker-image.sh
exit
vagrant -f destroy
```

### 其它說明
 
 - 如何建立Vagrantfile
 - 使用box add 加入
 - 使用box list 查訊目前已加入
 - 使用vagrant init，在本地位置建立Vagrantfile

```
vagrant box add hashicorp/precise32
vagrant box list 
vagrant init
```

 - 查看 vagrant up帶起來訊息如下
 
```
erwin@mini-pc:/opt/data/data/github/docker/ubuntu14.04-i386$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Checking if box 'ubuntu/trusty32' is up to date...
==> default: Clearing any previously set forwarded ports...
==> default: Fixed port collision for 22 => 2222. Now on port 2200.
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 22 => 2200 (adapter 1)
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2200
    default: SSH username: vagrant
    default: SSH auth method: private key
    default: Warning: Connection timeout. Retrying...
    default: Warning: Connection timeout. Retrying...
    default: Warning: Remote connection disconnect. Retrying...
    default: Warning: Remote connection disconnect. Retrying...
    default: Warning: Remote connection disconnect. Retrying...
    default:
    default: Vagrant insecure key detected. Vagrant will automatically replace
    default: this with a newly generated keypair for better security.
    default:
    default: Inserting generated public key within guest...
    default: Removing insecure key from the guest if it's present...
    default: Key inserted! Disconnecting and reconnecting using new SSH key...
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
==> default: Mounting shared folders...
    default: /vagrant => /opt/data/data/github/docker/ubuntu14.04-i386

```

[1]:https://github.com/toopher/toopher-docker/tree/master/ubuntu12.04-i386