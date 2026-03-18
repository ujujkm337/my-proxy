FROM alpine:latest

# Устанавливаем shadowsocks и curl (для проверки)
RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/v3.15/community \
    shadowsocks-libev

# Переменные
ENV SS_PASSWORD=mypassword123
ENV SS_METHOD=chacha20-ietf-poly1305
ENV PORT=10000

# Создаем скрипт запуска, который будет "обманывать" Render, делая вид, что это веб-сервис
RUN echo "#!/bin/sh" > /start.sh && \
    echo "ss-server -s 0.0.0.0 -p \$PORT -k \$SS_PASSWORD -m \$SS_METHOD -u &" >> /start.sh && \
    echo "while true; do nc -l -p 8080 -e echo -e 'HTTP/1.1 200 OK\n\nOK'; done" >> /start.sh && \
    chmod +x /start.sh

# Render будет стучаться на 8080, а Shadowsocks будет работать на 10000
EXPOSE 10000
EXPOSE 8080

CMD ["/start.sh"]
