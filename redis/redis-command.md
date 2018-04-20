# redis clear pattern data
redis-cli -a abc123 --raw keys "*:friendlist" | xargs redis-cli -a abc123 del
del user:1:friendlist

## redis 修改密码
修改redis配置文件 /etc/redis/redis.conf
requirepass 'your password'

## redis 模式匹配删除
import redis
pool = redis.ConnectionPool(
            host=config['host'],
            port=config['port'],
            password=config['password'],
            db=config['db'],
            decode_responses=True
        )
conn = redis.strictRedis(connection_pool=pool)
hotel_key = conn.keys('hotel*')
for key in hotel_key:
    test_conn.delete(key)
