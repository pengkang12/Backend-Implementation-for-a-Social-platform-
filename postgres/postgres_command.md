## postgres 创建用户后，修改密码
sudo -u postgres psql 


## postgres 备份与恢复

pg_dump -h localhost -p 5430 -U postgres gaidb > gaidb.sql

psql –h 127.0.0.1 –U postgres nova < /tmp/nova.sql

## postgres 删除所有表的数据

DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

If you are using PostgreSQL 9.3 or greater, you may also need to restore the default grants.

GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;
