#!/bin/bash
set -e
mkdir -p /opt/tools/bin /var/backups

cat > /opt/tools/bin/backup-now <<'EOF'
#!/bin/bash
date > /var/backups/last-backup.txt
echo "backup ok"
EOF
chmod +x /opt/tools/bin/backup-now

# Для человека в терминале PATH дополнен, а у cron свой короткий PATH
echo 'export PATH="$PATH:/opt/tools/bin"' > /etc/profile.d/tools.sh

# Вывод никуда не сохраняется — ошибку не видно
cat > /etc/cron.d/backup <<'EOF'
# Бэкап каждую минуту
* * * * * root backup-now
EOF
chmod 644 /etc/cron.d/backup
