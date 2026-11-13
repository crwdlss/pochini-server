#!/bin/bash
set -e
mkdir -p /opt/app /srv/old-dashboard
echo "Старый дашборд. Не используется с 2023 года." > /srv/old-dashboard/README.txt

cat > /opt/app/app.py <<'EOF'
from http.server import BaseHTTPRequestHandler, HTTPServer

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"APP OK\n")

    def log_message(self, *args):
        pass

print("Starting app on 0.0.0.0:8080", flush=True)
HTTPServer(("0.0.0.0", 8080), Handler).serve_forever()
EOF

cat > /usr/local/bin/start-app <<'EOF'
#!/bin/bash
setsid -f python3 /opt/app/app.py >> /var/log/app.log 2>&1
sleep 1
if curl -fs --max-time 2 http://localhost:8080 | grep -q "APP OK"; then
    echo "✅ Приложение запущено на порту 8080"
else
    echo "❌ Приложение не запустилось, смотри /var/log/app.log"
    exit 1
fi
EOF
chmod +x /usr/local/bin/start-app
