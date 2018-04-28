#!/bin/bash
SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin

# stop redis 
/usr/local/bin/redis-cli -a abc123 shutdown

sleep 5

# 移除旧的数据
mv /var/lib/redis/6379/dump.rdb /var/lib/redis/6379/dump.rdb.old.$(date +%Y%m%d%H)

cp -p /home/django/backup/redis/dump.rdb /var/lib/redis/6379/

chown root:root /var/lib/redis/6379/dump.rdb
# start redis

/etc/init.d/redis_6379 start

echo "success"

/usr/local/bin/supervisorctl restart celeryWorker
