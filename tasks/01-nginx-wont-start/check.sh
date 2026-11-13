#!/bin/bash
source /opt/lib.sh

nginx -t >/dev/null 2>&1 || fail "Конфиг nginx всё ещё с ошибкой (проверь: nginx -t)"
ok "Конфиг nginx валидный"

pgrep -x nginx >/dev/null || fail "Конфиг исправлен, но nginx не запущен"
ok "nginx запущен"

curl -fs http://localhost/ | grep -q "Сервер починен" || fail "curl http://localhost не показывает нужную страницу"
ok "Сайт открывается"

solved
