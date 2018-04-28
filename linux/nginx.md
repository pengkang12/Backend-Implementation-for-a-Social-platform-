ubuntu 16.04
nginx 第一次认证
sudo certbot --authenticator standalone --installer nginx --pre-hook "service nginx stop" --post-hook "service nginx start"


nginx certbot重新生成认证
sudo certbot certonly 
选2，standalone
然后输入域名


### nginx 无法从http跳转到https
修改 /etc/nginx/sites-available/default
```
     listen 443 ssl; # managed by Certbot
     ssl_certificate /etc/letsencrypt/live/xxx/fullchain.pem; # managed by Certbot
     ssl_certificate_key /etc/letsencrypt/live/xxx/privkey.pem; # managed by Certbot
     include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
     ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


    if ($scheme != "https") {
        return 301 https://$host$request_uri;
    } # managed by Certbot
```


### 检查nginx进程打开文件数量
ps aux | grep nginx
获得进程号
cat /proc/xxxx/limits
查看当前进程的最大资源数量


### nginx提高并发度

/etc/systemd/system/multi-user.target.wants中，编辑 nginx.service

[Service]
....
TimeoutStopSec=5
KillMode=mixed
# 增加进程打开文件个数
LimitNOFILE=30000

修改后，执行下面命令,生效配置

```
systemctl daemon-reload
systemctl restart nginx 
```

nginx 配置

```
worker_processes 2; 跟服务器核数相关
pid /run/nginx.pid;
worker_rlimit_nofile 30000;

events {
	worker_connections 20000;最大连接数
	use epoll;使用epoll方法
	multi_accept on;将请求分配到多个进程中
}
```



### supervisor 管理 uwsgi，同样设置supervisor.service

