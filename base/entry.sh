#!/bin/bash
# Точка входа контейнера: запускаем "поломку" и отдаём пользователю shell

if [ -x /opt/task/start.sh ]; then
    /opt/task/start.sh >/dev/null 2>&1 || true
fi

clear 2>/dev/null || true
cat /opt/task/TASK.md
echo
echo "----------------------------------------------------------------"
echo " Команды:  task  — условие   hint — подсказка   check — проверка"
echo "           exit  — выйти (контейнер удалится, всё сбросится)"
echo " Не подглядывай в /opt/task — там проверка и ответы :)"
echo "----------------------------------------------------------------"
echo

cd /root
exec bash -l
