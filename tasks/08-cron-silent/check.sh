#!/bin/bash
source /opt/lib.sh

pgrep -x cron >/dev/null || fail "Демон cron не запущен (запусти командой: cron)"
ok "cron запущен"

rm -f /var/backups/last-backup.txt
info "Удалил /var/backups/last-backup.txt. Жду, пока cron создаст его сам (до 70 секунд)..."
for _ in $(seq 1 14); do
    sleep 5
    if [ -f /var/backups/last-backup.txt ]; then
        ok "cron выполнил бэкап: $(cat /var/backups/last-backup.txt)"
        solved
        exit 0
    fi
done
fail "За 70 секунд cron не сделал бэкап"
