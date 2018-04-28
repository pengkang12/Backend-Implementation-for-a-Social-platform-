#!/bin/bash

if [ -e /home/django/backup/postgres/gaidb.sql ]
then
   mv /home/django/backup/postgres/gaidb.sql /home/django/backup/postgres/gaidb.sql.$(date +%Y%m%d%H)
fi

pg_dump --dbname=postgres://postgres:abcd1234@127.0.0.1:5430/gaidb > ~/backup/postgres/gaidb.sql
