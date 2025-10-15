# Imagen base oficial de Ollama
FROM ollama/ollama:latest

# Instalar Node.js y dependencias
RUN apt-get update && apt-get install -y nodejs npm

# Crear directorio de la app
WORKDIR /app

# Copiar todos los archivos del proyecto
COPY . .

# Dar permisos al script de inicio
RUN chmod +x start.sh

# Exponer el puerto donde corre tu API
EXPOSE 11434

# Comando de arranque
CMD ["./start.sh"]
