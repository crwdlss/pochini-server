#!/bin/bash
set -e
mkdir -p /etc/myapp /opt/backend
echo 'BACKEND_URL=http://backend.local:8000' > /etc/myapp/config.env
sha256sum /etc/myapp/config.env > /opt/task/.config.sha256

cat > /opt/backend/backend.py <<'EOF'
from http.server import BaseHTTPRequestHandler, HTTPServer

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"BACKEND OK\n")

    def log_message(self, *args):
        pass

HTTPServer(("127.0.0.1", 8000), Handler).serve_forever()
EOF

cat > /usr/local/bin/myapp-status <<'EOF'
#!/bin/bash
source /etc/myapp/config.env
curl -fs --max-time 3 "$BACKEND_URL" || echo "ОШИБКА: backend недоступен по адресу $BACKEND_URL"
EOF
chmod +x /usr/local/bin/myapp-status
