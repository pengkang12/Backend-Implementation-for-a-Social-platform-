1. run update.sh


2. recovery postgres
# first recovery postgres
psql -U postgres -h localhost -p 5430 gaidb -f data/gaidb.sql

# enter docker 
docker exec -it dockercompose_test bash

3. django makemigrations
# execute in docker
python manage.py makemigrations 
python manage.py migrate

# redis recovery data
redis-cli -p 6781 -a abc123 bgsave
docker-compose stop redis
scp username@ip:~/backup/redis/dump.rdb /home/django/new_gai_dep/data/redis/
docker-compose start redis
# migrate
migrate出现错误时，可能跟migrate版本有关系，修改相关的migrate文件

删除错误数据字段，如果已经有的，删除已经有的，如果没有，则删除0001文件的创建字段
数据恢复的方法，首先migrate生产机数据，然后再使用pgdump导出数据。
然后再用导出的数据恢复生产环境。
