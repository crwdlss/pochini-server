#!/bin/bash
set -e
rm -f /var/www/html/index.nginx-debian.html
echo "<h1>Страница доступна</h1>" > /var/www/html/index.html

cat > /etc/nginx/sites-available/default <<'EOF'
server {
    listen 80 default_server;
    root /var/www/html;
    index index.html;
    server_name _;

    location / {
        try_files $uri $uri/ =404;
    }
}
EOF

# Две поломки сразу: и файл, и папка недоступны пользователю www-data
chown -R root:root /var/www/html
chmod 600 /var/www/html/index.html
chmod 700 /var/www/html
