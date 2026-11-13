#!/bin/bash
set -e
cat > /usr/local/bin/app-save <<'EOF'
#!/bin/bash
# Сохраняет 4 МБ данных приложения
head -c 4M /dev/zero > /data/app/state.db && echo "Данные сохранены"
EOF
chmod +x /usr/local/bin/app-save
