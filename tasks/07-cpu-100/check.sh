#!/bin/bash
source /opt/lib.sh

info "Наблюдаю за сервером 10 секунд..."
for _ in $(seq 1 10); do
    if pgrep -f backup-helper >/dev/null; then
        fail "Процесс, который грузит CPU, всё ещё работает (или вернулся). Кто его запускает?"
    fi
    sleep 1
done
ok "Нагрузка на CPU ушла и не вернулась"

pgrep -f "app-server" >/dev/null || fail "app-server остановлен — его нельзя было трогать"
curl -fs --max-time 2 http://localhost:8081 | grep -q "APP OK" || fail "app-server не отвечает на 8081"
ok "app-server работает"

solved
