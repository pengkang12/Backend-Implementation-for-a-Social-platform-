python manage.py celery inspect scheduled

Celery 集群部署，beat只能启动一个，worker可以有多个。

Python分布式计算

```
celery -A proj worker -l info

celery -A proj beat -l info --scheduler django_celery_beat.schedulers:DatabaseScheduler
```

