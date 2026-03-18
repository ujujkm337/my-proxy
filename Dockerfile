FROM alpine:latest

# Обновляем репозитории и устанавливаем shadowsocks-libev из веточки community
RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
    shadowsocks-libev \
    libmgrs

# Переменные среды
ENV SS_PASSWORD=mypassword123
ENV SS_METHOD=chacha20-ietf-poly1305
ENV PORT=10000

# Запускаем сервер
# Мы используем ss-server (часть пакета shadowsocks-libev)
CMD ss-server \
    -s 0.0.0.0 \
    -p $PORT \
    -k $SS_PASSWORD \
    -m $SS_METHOD \
    --reuse-port \
    -u
