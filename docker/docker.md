## docker command
```
docker restart dockercompose_test_1

docker exec -it dockercompose_test_1 bash

docker exec -it dockercompose_test_1 /usr/local/bin/supervisorctl restart celeryWorker
```
## docker-compose
```
docker-compose down
docker-compose build
docker-compose up -d
```


## docker run gitlab
```
sudo docker run --detach --name gitlab2 \
                --hostname [your ip address] \
                --publish 30080:30080 \
                --publish 30022:22 \
                --publish 465:465 \
                --env GITLAB_OMNIBUS_CONFIG="external_url 'http://[your ip address]:30080'; gitlab_rails['gitlab_shell_ssh_port']=30022;" \
                --volume /home/django/gitlab/data:/var/opt/gitlab \
                --volume /home/django/gitlab/config:/etc/gitlab \
                --volume /home/django/gitlab/log:/var/log/gitlab \
                --cpus="1" \
                gitlab/gitlab-ce:latest
```

## docker start postgres
```
sudo docker run --detach --name postgres1 \
                --publish 5432:5432 \
                --volume /home/xxxx/service/postgres/data:/var/lib/postgresql/data \
                --env POSTGRES_PASSWORD="password" \
                --env POSTGRES_USER="postgres" \
                --cpus="0.5" \
                postgres:9.5
```
