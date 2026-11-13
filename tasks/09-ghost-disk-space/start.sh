#!/bin/bash
mkdir -p /data/logs
setsid -f bash -c 'exec -a log-writer bash /opt/svc/log-writer.sh' >/dev/null 2>&1

# Ждём, пока лог разрастётся
for _ in $(seq 1 30); do
    size=$(stat -c %s /data/logs/service.log 2>/dev/null || echo 0)
    [ "$size" -ge $((26 * 1024 * 1024)) ] && break
    sleep 0.5
done

# "Дежурный" удалил лог, но процесс всё ещё держит файл открытым
rm -f /data/logs/service.log
pgrep -f log-writer > /opt/task/.writer.pid
