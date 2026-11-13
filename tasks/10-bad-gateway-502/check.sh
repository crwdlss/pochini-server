#!/bin/bash
source /opt/lib.sh

pgrep -f "python3 /opt/api/api.py" >/dev/null || fail "Процесс API не запущен"
ok "API запущен"

pgrep -x nginx >/dev/null || fail "nginx не запущен"
nginx -t >/dev/null 2>&1 || fail "В конфиге nginx ошибка (nginx -t)"
ok "nginx работает, конфиг валидный"

curl -fs --max-time 3 http://localhost/ | grep -q "API OK" \
    || fail "curl http://localhost не отвечает 'API OK' — цепочка nginx → API ещё не работает"
ok "Запрос проходит через nginx до API"

solved
