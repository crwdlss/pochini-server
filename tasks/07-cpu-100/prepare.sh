#!/bin/bash
set -e
mkdir -p /opt/app /opt/sys

cat > /opt/app/server.py <<'EOF'
from http.server import BaseHTTPRequestHandler, HTTPServer

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"APP OK\n")

    def log_message(self, *args):
        pass

HTTPServer(("0.0.0.0", 8081), Handler).serve_forever()
EOF

# "Помощник бэкапа" с бесконечным циклом
cat > /opt/sys/helper.sh <<'EOF'
#!/bin/bash
while :; do :; done
EOF

# Сторож, который перезапускает помощника, если его убить
cat > /opt/sys/monitor.sh <<'EOF'
#!/bin/bash
while true; do
    if ! pgrep -f backup-helper >/dev/null; then
        bash -c 'exec -a backup-helper bash /opt/sys/helper.sh' &
    fi
    sleep 3
done
EOF
chmod +x /opt/sys/*.sh
