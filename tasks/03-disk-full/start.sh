#!/bin/bash
# /data — маленький диск на 20 МБ (tmpfs)
mkdir -p /data/app/logs/.archive
printf 'db_path: /data/app/state.db\nlog_level: info\n' > /data/app/config.yml

# Виновник спрятан в скрытой папке — "du -sh /data/app/logs/*" его не покажет
head -c 18M /dev/urandom > /data/app/logs/.archive/debug-2024-full.log
for i in $(seq 1 50); do echo "$(date) INFO request handled" ; done > /data/app/logs/app.log

# Добиваем остаток места мелким мусором
head -c 2M /dev/zero > /data/app/logs/.archive/filler.tmp 2>/dev/null || true
