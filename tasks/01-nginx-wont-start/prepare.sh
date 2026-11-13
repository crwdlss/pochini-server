#!/bin/bash
set -e
echo "<h1>Сервер починен</h1>" > /var/www/html/index.html

# Пропущена точка с запятой после listen
cat > /etc/nginx/sites-available/default <<'EOF'
server {
    listen 80 default_server
    root /var/www/html;
    index index.html;
    server_name _;

    location / {
        try_files $uri $uri/ =404;
    }
}
EOF
