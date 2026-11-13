FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# Набор утилит, которые есть почти на любом реальном сервере
RUN apt-get update && apt-get install -y --no-install-recommends \
        nginx curl python3 procps psmisc cron lsof iproute2 \
        bind9-dnsutils nano vim-tiny less ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY bin/ /usr/local/bin/
COPY lib.sh /opt/lib.sh
COPY entry.sh /opt/entry.sh
RUN chmod +x /usr/local/bin/* /opt/entry.sh

CMD ["/opt/entry.sh"]
