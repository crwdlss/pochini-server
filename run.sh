#!/usr/bin/env bash
# Запуск задачи:  ./run.sh 01
set -euo pipefail
cd "$(dirname "$0")"

if [ $# -ne 1 ]; then
    echo "Использование: ./run.sh <номер задачи>   например: ./run.sh 01"
    echo
    echo "Задачи:"
    ls tasks
    exit 1
fi

dir=$(ls -d tasks/"$1"-* 2>/dev/null | head -n 1 || true)
if [ -z "$dir" ]; then
    echo "Задача '$1' не найдена. Список: ls tasks"
    exit 1
fi
name=$(basename "$dir")

echo "⏳ Готовлю сервер для задачи $name (первый запуск займёт пару минут)..."
docker build -q -t pochini-base base >/dev/null
docker build -q -t "pochini-$name" --build-arg TASK="$name" -f base/Dockerfile.task . >/dev/null

flags=()
if [ -f "$dir/run.flags" ]; then
    read -r -a flags < "$dir/run.flags"
fi

docker run -it --rm --hostname "srv-${name%%-*}" "${flags[@]}" "pochini-$name"
