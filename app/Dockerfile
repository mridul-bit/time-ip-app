FROM node:20-slim
WORKDIR /usr/src/app
RUN groupadd -r time-ip-appgroup && useradd -r -g time-ip-appgroup time-ip-appuser
COPY package*.json ./
RUN npm install --omit==dev

COPY . .

RUN chown -R time-ip-appuser:time-ip-appgroup /usr/src/app
USER time-ip-appuser

EXPOSE 3000

CMD ["npm", "start"]

