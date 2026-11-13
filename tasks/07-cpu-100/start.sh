#!/bin/bash
setsid -f bash -c 'exec -a app-server python3 /opt/app/server.py' >/dev/null 2>&1
setsid -f bash -c 'exec -a sys-monitor bash /opt/sys/monitor.sh' >/dev/null 2>&1
sleep 1
