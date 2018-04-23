# jira 敏捷开发

### jira 搭建
注意事项：系统硬件配置要求
4 core 2GHZ+ CPU
RAM 6G

### jira java必须使用过oracle java
jdk-8u161-linux-x64.tar.gz

安装好java后设置环境变量
export JAVA_HOME=/home/django/service/jdk1.8.0_161/

### jira 下载最新版7.8.1
atlassian-jira-software-7.8.1.tar.gz

安装方式见 jira安装包readme.txt

jira环境变量配置
export JIRA_HOME=你的jira绝对路径/jira/home


jira 启动 sudo bin/jira-start.sh
     关闭 sudo bin/shutdown.sh

### 数据库使用postgres
直接使用docker下载postgres
postgres 启动命令
sudo docker run --detach --name postgres1 \
                --publish 5432:5432 \
                --volume /home/django/service/postgres/data:/var/lib/postgresql/data \
                --env POSTGRES_PASSWORD="xxxx" \
                --env POSTGRES_USER="postgres" \
                --cpus="0.5" \
                postgres:9.5


docker 快照保存数据库数据
docker export postgres1 > jiradb.tar

docker 快照数据导入恢复
docker import postgres1 < jiradb.tar
