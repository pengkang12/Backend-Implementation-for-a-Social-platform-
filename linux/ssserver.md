```
sudo apt install python-dev
sudo pip install shadowsockets

sudo apt install libsodium-dev

support 1305 协议

wget https://download.libsodium.org/libsodium/releases/libsodium-1.0.15.tar.gz
tar xvzf libsodium-1.0.15.tar.gz
cd libsodium-1.0.15
./configure
make
sudo make install
cd ..

echo /usr/local/lib > /etc/ld.so.conf.d/usr_local_lib.conf
ldconfig
```

ss config文件
```

```
 开始ssserver
 ssserver -c config.json -f ss-server.pid
