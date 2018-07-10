ab -p login.json -T application/json -c 10 -n 200 http://127.0.0.1:8080/mlogin/

curl -H "Content-Type: application/json" -X POST -d '{"mobile":"+8618930134768","password":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXNzd29yZCI6IjEyMzQ1NiJ9.MfJR_COyEoa2cD1zvK6gcpL5i6Z5Z0z_J8SWoKzpo8w"}' http://localhost:8021/mlogin/

curl -H "Content-Type: application/json" -H 'Authorization: JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Iis4NjE4OTMwMTM0NzY4Iiwib3JpZ19pYXQiOjE1MjIzMTg1OTgsIm1vYmlsZSI6Iis4NjE4OTMwMTM0NzY4IiwiZXhwIjoxNTIyMzQwMTk4LCJ1c2VyX2lkIjoxMSwiZW1haWwiOiIifQ.uA-g7WzcGrlrZMtCZLRM0h6ZUoY0tbAjxESpAMd7cek' -X POST -d '{"record_id":611, "text": "absd", "reply": 30}' http://localhost:8021/emotion/comment/

install hey


hey -n 10000 -q 200 -c 200 -z 30s -m POST -H 'Content-Type: application/json' -D login.json https://api.xiaogaijun.com/mlogin/
