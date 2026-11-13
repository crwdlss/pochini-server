#!/bin/bash
# Забытый старый сервис занимает 8080
setsid -f bash -c 'exec -a old-dashboard python3 -m http.server 8080 --directory /srv/old-dashboard' >/dev/null 2>&1
sleep 1
