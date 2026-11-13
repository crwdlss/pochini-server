#!/bin/bash
set -e
mkdir -p /opt/svc

# Сервис держит лог открытым и пишет в него
cat > /opt/svc/log-writer.sh <<'EOF'
#!/bin/bash
exec 3>>/data/logs/service.log
head -c 26M /dev/urandom >&3
while true; do
    echo "$(date) client request served" >&3
    sleep 5
done
EOF
chmod +x /opt/svc/log-writer.sh

cat > /usr/local/bin/app-save <<'EOF'
#!/bin/bash
# Сохраняет 10 МБ данных приложения
head -c 10M /dev/zero > /data/state.db && echo "Данные сохранены"
EOF
chmod +x /usr/local/bin/app-save
