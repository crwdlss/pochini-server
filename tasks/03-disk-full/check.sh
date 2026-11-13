#!/bin/bash
source /opt/lib.sh

[ -f /data/app/config.yml ] || fail "Удалён /data/app/config.yml — это был важный конфиг!"
[ -f /data/app/logs/app.log ] || fail "Удалён текущий лог /data/app/logs/app.log — его нужно было сохранить"
ok "Нужные файлы на месте"

app-save >/dev/null 2>&1 || fail "app-save всё ещё не может записать данные"
ok "app-save работает"

solved
