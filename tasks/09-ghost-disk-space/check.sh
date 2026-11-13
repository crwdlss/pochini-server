#!/bin/bash
source /opt/lib.sh

orig_pid=$(cat /opt/task/.writer.pid 2>/dev/null)
cur_pid=$(pgrep -f log-writer | head -n 1)
[ -n "$cur_pid" ] || fail "log-writer не работает — его нельзя было убивать"
[ "$cur_pid" = "$orig_pid" ] || fail "log-writer перезапускали (другой PID) — по условию так нельзя"
ok "log-writer работает, его не трогали"

rm -f /data/state.db
app-save >/dev/null 2>&1 || fail "app-save всё ещё не может записать данные — место не освободилось"
rm -f /data/state.db
ok "Место освобождено, app-save работает"

solved
