# Usamos imagen oficial de Node.js
FROM node:20-slim

# Instalar curl y otras dependencias necesarias
RUN apt-get update && apt-get install -y curl bash && rm -rf /var/lib/apt/lists/*

# Configuramos el directorio de la app
WORKDIR /app

# Copiamos package.json y package-lock.json
COPY package*.json ./

# Instalamos dependencias de Node.js
RUN npm install

# Copiamos el resto del código
COPY . .

# Hacemos ejecutables los scripts
RUN chmod +x start.sh server.js

# Exponemos el puerto de Node.js (Render solo necesita uno)
EXPOSE 3000

# Comando por defecto
CMD ["./start.sh"]
