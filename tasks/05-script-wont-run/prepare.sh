#!/bin/bash
set -e
mkdir -p /opt/scripts
# Две поломки: нет права на исполнение + переводы строк Windows (CRLF)
printf '#!/bin/bash\r\n# Backup script\r\necho "Бэкап выполнен"\r\ntouch /tmp/backup.ok\r\n' > /opt/scripts/backup.sh
chmod 644 /opt/scripts/backup.sh
