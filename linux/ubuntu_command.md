# 查看系统信息
uname

# ufw

## tar 压缩文件和解压缩文件
tar –czf jpg.tar.gz *.jpg
tar -xzvf file.tar.gz //解压tar.gz

## 配置防火墙
sudo ufw status
sudo ufw enable
sudo ufw disable

sudo ufw allow 53
sudo ufw delete allow 53
sudo ufw allow from 15.15.15.0/24  to any port 22
sudo ufw delete allow from 15.15.15.0/24  to any port 22

## 检查系统状态
vmstat
htop，top
iostat -x 1
dstat
sar
