#!/bin/bash

echo "stop nginx"
sudo service nginx stop
echo "stop nginx success"
cd /home/django/new_gai_dep/gailvlun
git pull origin2 master

echo "restart websocket"
docker restart dockercompose_ws1_1
docker restart dockercompose_ws2_1

# make migration
docker exec -it dockercompose_gailvlun2_1 python manage.py makemigrations 
docker exec -it dockercompose_gailvlun2_1 python manage.py migrate

echo "restart uwsgi and celeryWorker"
docker exec -it dockercompose_gailvlun2_1 /usr/local/bin/supervisorctl restart uwsgi
docker exec -it dockercompose_gailvlun2_1 /usr/local/bin/supervisorctl restart celeryWorker
docker exec -it dockercompose_gailvlun1_1 /usr/local/bin/supervisorctl restart uwsgi
docker exec -it dockercompose_gailvlun1_1 /usr/local/bin/supervisorctl restart celeryWorker

echo "start nginx"
sudo service nginx start
echo "start nginx success"
