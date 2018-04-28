#!/bin/bash
SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin

echo 'back up data'
if [ -e /home/django/backup/postgres/gaidb.sql ]
then
   /bin/mv /home/django/backup/postgres/gaidb.sql /home/django/backup/postgres/gaidb.sql.$(date +%Y%m%d%H)
fi

echo "generate new back data"
/usr/bin/ssh -l django 120.79.206.107 "bash ~/backup/back.sh"

echo "waiting back up"
/bin/sleep 1m

echo "copy backup data to server."
/usr/bin/scp django@120.79.206.107:/home/django/backup/postgres/gaidb.sql /home/django/backup/postgres/

echo "delete old database"
/usr/bin/psql -h localhost -p 5432 -U postgres -d gaidb -A -f /home/django/backup/drop_db.sql
echo "create new database"
/usr/bin/psql -h localhost -p 5432 -U postgres -d gaidb -A -f /home/django/backup/postgres/gaidb.sql

echo "success"
#/usr/bin/python /home/django/new_gai_dep/gailvlun/manage.py makemigrations --settings=gailvlun.settings.development
#/usr/bin/python /home/django/new_gai_dep/gailvlun/manage.py migrate --settings=gailvlun.settings.development

echo "delete old database"
/usr/bin/psql -h localhost -p 5432 -U postgres -d test_gaidb -A -f /home/django/backup/drop_db.sql

pg_dump -Upostgres -h localhost -p 5432 gaidb | psql -U postgres -h localhost -p 5432 test_gaidb
