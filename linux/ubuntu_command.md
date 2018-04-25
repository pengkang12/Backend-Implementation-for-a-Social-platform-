# 查看系统信息
uname

# ufw

## tar 压缩文件和解压缩文件
tar –czf jpg.tar.gz *.jpg
tar -xzvf file.tar.gz //解压tar.gz

## 配置防火墙

```
sudo ufw status
sudo ufw enable
sudo ufw disable

sudo ufw allow 53
sudo ufw delete allow 53
sudo ufw allow from 15.15.15.0/24  to any port 22
sudo ufw delete allow from 15.15.15.0/24  to any port 22
```

## 检查系统状态

```
vmstat
htop，top
iostat -x 1
dstat
sar
```

## 统计代码行数，去除空行
find . -name "*.py"|xargs cat|grep -v ^$|wc -l

## 生效环境变量 
source ~/work/myenv/bin/activate

## 设置快捷键别名
alias ssh-dev="ssh -l django 100.100.100.100"

## 挂载一个新的磁盘
### 查看现有磁盘
df –h

### 查看某个文件大小
du -sh /home

### 挂载一块新的磁盘
fdisk -l
### 格式化新的磁盘
fdisk /dev/sdb
mkfs -t ext4 -c /dev/sdb1

### 备份fstab文件 
sudo cp /etc/fstab /etc/fstab.$(date +%Y-%m-%d)

### 复制数据

```
rsync -avPHSX /var/lib/docker /new/partition/
-a，档案模式。
-v，显示详细信息。
-P，显示进度。
-H，处理Hardlink为Hardlink，关键！
-S，稀疏文件优化处理。
-X，保留所有属性。
```

## 将某个文件映射到新磁盘上
### 修改fstab 在该文件中把下面一行添加到fstab里，将新位置挂载到 /var/lib/docker 
/data/docker /var/lib/docker  none bind 0 0

### 重新挂载文件
mount -a




### reference
https://my.oschina.net/u/2306127/blog/653569

