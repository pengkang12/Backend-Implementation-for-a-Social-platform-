#!/bin/bash -xe

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/root
PATH=$PATH:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

if [ -e /home/django/backup/redis/dump.rdb ]
then
   mv /home/django/backup/redis/dump.rdb /home/django/backup/redis/dump.rdb.$(date +%Y%m%d%H)
fi

/usr/bin/redis-cli -a abc123 save

cp ~/new_gai_dep/data/redis/dump.rdb ~/backup/redis/
