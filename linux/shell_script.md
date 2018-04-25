### 免密码复制

```
#!/usr/bin/expect
spawn -noecho /usr/bin/scp -r doc/main.js user@xxx.xxx.xxx.xxx:/home/user/document
expect "password:"
send "your password\r"
interact
```

### 免密码登录

```
#!/usr/bin/expect

spawn -noecho /usr/bin/ssh -l user xx.xx.xxx.xxx
expect "password:"
send "your password\r"
interact
```

