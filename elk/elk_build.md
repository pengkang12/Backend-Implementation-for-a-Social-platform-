### ELK introduction

### architecture

```
Logstash shippers->Redis(cluster)->Logstash index->Elasticseach->Kibana

[data collection-----------------] [ data storation-----------]  [data showing]
```

### Redis or Kafka
In short, when dealing with real-time messages processing with a minimal latency, we may want to try Redis. 
However, in case that messages are large and data should be reused, Kafka should be our choice.

In our log system, we choose Redis. 



#### reference
https://dzone.com/articles/elk-using-centralized-logging
https://www.oreilly.com/ideas/understanding-the-elk-stack



### 下载ELK5.5 和 sentinal 5.5

https://www.elastic.co/downloads/

https://github.com/sirensolutions/sentinl

搭建环境说明：ubuntu 16.2， java openjdk-1.8

不要选择高版本的ELK去搭建，不然只能使用付费版。
这里选择ELK 5.5 使用x-pack后需要激活，选择基础版就可以了，激活方法看文档说明。

ELK启动顺序 elasticsearch ==> logstash ==> kibana

目录路径：
~/backend_service/ELK/

### Elasticsearch

```
config/jvm.options
- Xms1g
-Xmx1g
改变为（因为用的虚拟机内存比较小，所以选择响应的jvm内存也比较小）
-Xms256m
-Xmx256m
```

### 配置文件

### 启动

```
bin/elasticsearch-plugin install x-pack
bin/elasticsearch -d
elastic5.5 默认用户名和密码是elastic和changeme
```

### Logstach
Logstach 配置文件 logstach.conf
该文件的位置： /home/django/backend_service/ELK/logstash-6.1.1/

```
input {
    file {
     type => "example_nginx_access"
        path => ["/var/log/nginx/example.access.log", "xxx"]

        start_position => "beginning"
        sincedb_path => "/dev/null"
    }
}

output {
     elasticsearch {

          action => "index"
            hosts  => ["localhost:9200"]
            index  => " logstash-xxxx-%{+YYYY.MM} "
            user => elastic
            password => changeme
     }


}
```

### 启动 Logstach

/home/django/backend_service/ELK/logstash-6.1.1/bin/logstach agent -f logstach.conf
如果是多个文件，直接定位到文件夹 bin/logstach agent -f conf.d

### kibana

kibana.yml文件
server.port: 5601
server.host: "0.0.0.0"
elasticsearch.url: "http://localhost:9200"

bin/kibana-plugin install x-pack

bin/kibana-plugin install  https://github.com/sirensolutions/sentinl (选择下载5.5版本)
bin/kibana

检查

http://localhost:5601
Username: elastic  Password: changeme

### 配置错误
 Elasticsearch启动出错
1.1 root用户启动elasticsearch报错
不让使用root启动，解决方法新建一个用户

1.2 JVM虚拟机内存不足
config目录下的jvm.options,默认为2g，可以修改为1g。

1.3  max_map_count过小
修改/etc/sysctl.conf配置文件，添加vm.max_map_count=262144， 需要重启机器
sysctl -w vm.max_map_count=262144
1.4 max file descriptors过小
/etc/security/limits.conf文件，添加“* - nofile65536 * - memlock unlimited”，“*”表示给所有用户起作用
ulimit -n 65536

logstash 启动慢的问题

JVM的随机数字生成参数导致，诊断和修改方式：
修改文件
$JAVA_HOME/jre/lib/security/java.security
设置参数
securerandom.source=file:/dev/urandom

重新启动
参考以下文档：

StackOverflow-Logstashstartup time #5491
-
Orace官方
-Avoiding JVM Delays Caused byRandom Number Generation

http://blog.csdn.net/qq_21387171/article/details/53577115

### ssl certbot认证

./certbot-auto certonly
按提示添加

nginx配置文件
server {
....
location ^~ /.well-known {
  allow all;
}
....
}

### 添加到supervisor中
修改/etc/supervisor/supervisor.conf

```
[program:elastic]
user=django
directory=/home/django/backend_service/ELK/elasticsearch
environment=DJANGO_SETTINGS_MODULE='gailvlun.settings.development'
command=/home/django/backend_service/ELK/elasticsearch/bin/elasticsearch
numprocs=1
stderr_logfile=/xxx/ELK/elastic.log
stdout_logfile=/xxx/ELK/elastic.log
autostart=true
autorestart=true
startsecs=30
stopwaitsecs = 600
killasgroup=true

[program:logstash]
user=django
directory=/home/django/backend_service/ELK/logstash
environment=DJANGO_SETTINGS_MODULE='gailvlun.settings.development'
command=/home/django/backend_service/ELK/logstash/bin/logstash -f /home/django/backend_service/ELK/logstash/conf.d
numprocs=1
stderr_logfile=/xxx/ELK/logstash.log
stdout_logfile=/xxx/ELK/logstash.log
autostart=true
autorestart=true
startsecs=30
stopwaitsecs = 600
killasgroup=true

[program:kibana]
user=django
directory=/home/django/backend_service/ELK/kibana
environment=DJANGO_SETTINGS_MODULE='gailvlun.settings.development'
command=/home/django/backend_service/ELK/kibana/bin/kibana
numprocs=1
stderr_logfile=/home/django/backend_service/ELK/kibana.log
stdout_logfile=/home/django/backend_service/ELK/kibana.log
autostart=true
autorestart=true
startsecs=30
stopwaitsecs = 600
killasgroup=true
```

supervisor update

grok filter 检查器
https://grokconstructor.appspot.com/do/match#result

KAAE 报警设置（需要在kibana.yml文件中配置邮件报警和slack报警）
```
kibana.yml文件中添加
xpack.security.encryptionKey: "e386d5f380dd962614538ad70d7e9745760f7e8e"
xpack.reporting.encryptionKey: "e386d5f380dd962614538ad70d7e9745760f7e8e"

sentinl:
  es:
    host: localhost
    port: 9200
    timefield: '@timestamp'
    default_index: watcher
    type: sentinl-watcher
    alarm_index: watcher_alarms
    alarm_type: sentinl-alarm
    script_type: sentinl-script
  sentinl:
    history: 20
    results: 50
    scriptResults: 50
  settings:
    email:
      active: true
      user: xxx@qq.cn （example） 
      password: xxxx
      host: smtp.exmail.qq.com
      ssl: true
      timeout: 10000  # mail server connection timeout
    slack:
      active: true
      username: username
      hook: 'https://hooks.slack.com/services/<token>'
      channel: '#channel(hook的channel)'
    webhook:
      active: false
      method: POST
      host: host
      port: 9200
      path: ':/{{payload.watcher_id}'
      body: '{{payload.watcher_id}}{payload.hits.total}}'
    report:
      active: true
      tmp_path: /tmp/
      search_guard: false
      simple_authentication: false
    pushapps:
      active: false
      api_key: '<pushapps API Key> '
```


样例raw
```
{
  "_index": "watcher",
  "_type": "sentinl-watcher",
  "_id": "u4beb5quhas-tczbm092vor-vibmn5px94n",
  "_version": 21,
  "found": true,
  "_source": {
    "title": "InternalServerError",
    "disable": false,
    "report": false,
    "trigger": {
      "schedule": {
        "later": "every 5 hour"
      }
    },
    "input": {
      "search": {
        "request": {
          "index": [
            "logstash-uwsgi*"
          ],
          "body": {
            "query": {
              "bool": {
                "must": [
                  {
                    "match_phrase": {
                      "message": "Internal Server Error"
                    }
                  },
                  {
                    "range": {
                      "@timestamp": {
                        "gte": "now-1d",
                        "lte": "now",
                        "format": "epoch_millis"
                      }
                    }
                  }
                ],
                "must_not": []
              }
            }
          }
        }
      }
    },
    "condition": {
      "script": {
        "script": "payload.hits.total > 10"
      }
    },
    "actions": {
      "emailNotification": {
        "throttle_period": "0h15m0s",
        "email": {
          "to": "peng.kang@gailvlun.cn",
          "from": "peng.kang@gailvlun.cn",
          "subject": "Sentinl Alarm",
          "priority": "high",
          "body": "Found {{payload.hits.total}} Events",
          "stateless": false
        }
      },
      "slackAlert": {
        "throttle_period": "0h1m0s",
        "slack": {
          "channel": "#elert",
          "message": "Found {{payload.hits.total}} Internal Server Error",
          "stateless": false,
          "save_payload": false
        }
      }
    },
    "transform": {}
  }
}
```
使用searchguard来做kibana的登录认证
http://docs.search-guard.com/v5/kibana-plugin-installation
