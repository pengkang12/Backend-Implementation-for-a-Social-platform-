## logstash文件，多行匹配

### 解释multiline
如果首行不是以I开头，则该行追加到前一行

```
input {
    file {
        type => "uwsgi"
        path => [
            "/home/django/log/uwsgi_out.log",
            "/home/django/log/uwsgi_out.log"
            ]
        codec => multiline {
            pattern => "^I"
            negate => true
            what => "previous"
        }
        tags => ["uwsgi"]
        start_position => "beginning"
    }
}

filter {
}
output {
if "uwsgi" in [tags] {
  elasticsearch {
    hosts => "http://xxx.xxx.xxx.xxx:9200"
    index => "logstash-uwsgi-%{+YYYY.MM}"
  }
}
}
```

