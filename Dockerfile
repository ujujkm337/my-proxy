FROM node:18-slim
WORKDIR /app
RUN npm install proxy-chain
# Порт на Render по умолчанию может быть любым, но мы зафиксируем 10000
EXPOSE 10000
CMD ["node", "-e", "const ProxyChain = require('proxy-chain'); const server = new ProxyChain.Server({ port: 10000, prepareRequestFunction: ({ username, password }) => { return { requestAuthentication: username !== 'user' || password !== 'mypassword123' }; } }); server.listen(() => { console.log('Proxy running on port 10000'); });"]
