FROM alpine:latest
RUN apk add --no-cache shadowsocks-libev
# Запускаем Shadowsocks на порту 10000
# Пароль: mypassword123, Шифрование: chacha20-ietf-poly1305
CMD exec ss-server \
      -s 0.0.0.0 \
      -p 10000 \
      -k mypassword123 \
      -m chacha20-ietf-poly1305 \
      --reuse-port \
      -u
