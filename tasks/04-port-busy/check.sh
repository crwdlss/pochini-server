#!/bin/bash
source /opt/lib.sh

grep -q '8080' /opt/app/app.py || fail "Порт приложения поменяли — по условию так нельзя"

curl -fs --max-time 2 http://localhost:8080 | grep -q "APP OK" \
    || fail "На порту 8080 не отвечает приложение (ожидаю 'APP OK')"
ok "На 8080 работает нужное приложение"

pgrep -f "python3 /opt/app/app.py" >/dev/null || fail "Процесс приложения не найден"
ok "Процесс приложения запущен"

solved
