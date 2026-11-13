#!/bin/bash
source /opt/lib.sh

(cd / && sha256sum -c --quiet /opt/task/.config.sha256 >/dev/null 2>&1) \
    || fail "Конфиг /etc/myapp/config.env изменён — по условию так нельзя"
ok "Конфиг приложения не тронут"

pgrep -f "backend.py" >/dev/null || fail "Процесс бэкенда не запущен — его нельзя было останавливать"
ok "Бэкенд работает"

if getent ahosts backend.local | grep -q "10.255.255.1"; then
    fail "backend.local всё ещё резолвится и в старый IP 10.255.255.1 — неверная запись осталась в /etc/hosts"
fi
ok "backend.local резолвится только в правильный адрес"

myapp-status | grep -q "BACKEND OK" || fail "myapp-status всё ещё не видит бэкенд"
ok "Приложение видит бэкенд"

solved
