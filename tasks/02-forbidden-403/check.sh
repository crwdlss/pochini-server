#!/bin/bash
source /opt/lib.sh

for p in /var/www/html /var/www/html/index.html; do
    [ -e "$p" ] || fail "$p пропал — его нельзя было удалять"
    mode=$(stat -c %a "$p")
    if (( 8#$mode & 8#002 )); then
        fail "$p доступен на запись всем (права $mode). Так делать нельзя — сделай аккуратнее"
    fi
done
ok "Права без дыр в безопасности"

curl -fs http://localhost/ | grep -q "Страница доступна" || fail "curl http://localhost всё ещё не показывает страницу"
ok "Сайт открывается"

solved
