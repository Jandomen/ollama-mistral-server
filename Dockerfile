FROM ollama/ollama:latest

RUN apt-get update && apt-get install -y nodejs npm curl

WORKDIR /app
COPY . .

RUN chmod +x start.sh server.js

EXPOSE 3000

ENTRYPOINT []  # Crucial para evitar el error "unknown command node"
CMD ["./start.sh"]