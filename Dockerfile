FROM ollama/ollama:latest

# Install Node.js, npm, and curl
RUN apt-get update && apt-get install -y nodejs npm curl

WORKDIR /app
COPY . .

# Install Node.js dependencies
RUN npm install

# Make scripts executable
RUN chmod +x start.sh server.js

# Expose ports for Node.js (3000) and Ollama (11434)
EXPOSE 3000 11434

ENTRYPOINT []
CMD ["./start.sh"]