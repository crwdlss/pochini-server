#!/bin/bash
source /opt/lib.sh

[ -x /opt/scripts/backup.sh ] || fail "У скрипта нет права на исполнение"
ok "Право на исполнение есть"

if grep -q $'\r' /opt/scripts/backup.sh; then
    fail "В скрипте остались Windows-переводы строк (CRLF)"
fi
ok "Переводы строк в формате Linux"

rm -f /tmp/backup.ok
out=$(/opt/scripts/backup.sh 2>&1) || fail "Скрипт завершился с ошибкой: $out"
echo "$out" | grep -q "Бэкап выполнен" || fail "Скрипт не напечатал 'Бэкап выполнен'"
[ -f /tmp/backup.ok ] || fail "Скрипт не выполнил свою работу (нет /tmp/backup.ok)"
ok "Скрипт запускается и работает"

solved
