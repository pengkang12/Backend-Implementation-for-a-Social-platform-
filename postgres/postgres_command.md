## postgres 创建用户后，修改密码
### 登录postgres数据库
sudo -u postgres psql 
### 更改密码
ALTER USER postgres WITH PASSWORD 'postgres';

## postgres 备份与恢复

pg_dump -h localhost -p 5432 -U postgres dbname > db_data.sql

psql –h 127.0.0.1 -p 5432 –U postgres dbname < /tmp/db_data.sql

## postgres 删除所有表的数据

DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

If you are using PostgreSQL 9.3 or greater, you may also need to restore the default grants.

GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;

## 查询
select * from table where key='value';

## 统计时间
\timing

## 查看表结构
\dt table

## 建立索引
To create a B-tree index on the column title in the table films:

CREATE UNIQUE INDEX title_idx ON films (title);

