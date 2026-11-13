#!/bin/bash
set -e
mkdir -p /opt/api

cat > /opt/api/api.py <<'EOF'
import os
from http.server import BaseHTTPRequestHandler, HTTPServer

port = int(os.environ["API_PORT"])

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"API OK\n")

    def log_message(self, *args):
        pass

print(f"API listening on 127.0.0.1:{port}", flush=True)
HTTPServer(("127.0.0.1", port), Handler).serve_forever()
EOF

# Поломка 1: переменная задана, но не экспортирована
echo 'API_PORT=5001' > /etc/api.env

cat > /usr/local/bin/start-api <<'EOF'
#!/bin/bash
source /etc/api.env
setsid -f python3 /opt/api/api.py >> /var/log/api.log 2>&1
sleep 1
echo "API запущен (лог: /var/log/api.log)"
EOF
chmod +x /usr/local/bin/start-api

# Поломка 2: nginx проксирует на старый порт
cat > /etc/nginx/sites-available/default <<'EOF'
server {
    listen 80 default_server;
    server_name _;

    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host $host;
    }
}
EOF
