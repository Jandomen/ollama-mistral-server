# Base: imagen oficial de Ollama
FROM ollama/ollama:latest

# Instalar Node.js, npm y curl
RUN apt-get update && apt-get install -y nodejs npm curl && rm -rf /var/lib/apt/lists/*

# Crear directorio de la app
WORKDIR /app

# Copiar package.json y package-lock.json
COPY package*.json ./

# Instalar dependencias de Node.js
RUN npm install

# Copiar el resto del código
COPY . .

# Hacer ejecutables los scripts
RUN chmod +x start.sh server.js

# Exponer el puerto de Node.js (Render solo necesita uno)
EXPOSE 3000

# Ejecutar start.sh con bash
CMD ["bash", "./start.sh"]
