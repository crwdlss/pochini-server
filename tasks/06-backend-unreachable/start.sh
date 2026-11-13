#!/bin/bash
setsid -f bash -c 'exec -a backend python3 /opt/backend/backend.py' >/dev/null 2>&1

# Кто-то давно прописал старый IP бэкенда. Docker пересоздаёт /etc/hosts
# при запуске, поэтому дописываем его здесь, а не при сборке образа.
echo "10.255.255.1    backend.local    # старый сервер бэкенда" >> /etc/hosts
