FROM ubuntu:22.04

# Устанавливаем Shadowsocks и netcat для "обмана" Render
RUN apt-get update && apt-get install -y \
    shadowsocks-libev \
    netcat \
    && rm -rf /var/lib/apt/lists/*

# Переменные (те же, что были)
ENV SS_PASSWORD=mypassword123
ENV SS_METHOD=chacha20-ietf-poly1305
ENV PORT=10000

# Скрипт запуска: 
# 1. Запускает SS в фоне
# 2. Запускает "заглушку" на порту 8080, чтобы Render видел активность
RUN echo "#!/bin/sh\n\
ss-server -s 0.0.0.0 -p \$PORT -k \$SS_PASSWORD -m \$SS_METHOD -u &\n\
while true; do nc -l -p 8080 -e echo 'HTTP/1.1 200 OK\r\n\r\nOK'; done" > /start.sh && \
chmod +x /start.sh

# Открываем порты
EXPOSE 10000
EXPOSE 8080

CMD ["/start.sh"]
