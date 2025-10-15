FROM ollama/ollama:latest

RUN apt-get update && apt-get install -y nodejs npm curl

WORKDIR /app
COPY . .

RUN chmod +x server.js

EXPOSE 3000

CMD ["node", "server.js"]
