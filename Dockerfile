# Imagen base oficial de Ollama
FROM ollama/ollama:latest

# Instalar Node.js y npm
RUN apt-get update && apt-get install -y nodejs npm curl

# Crear directorio de la app
WORKDIR /app

# Copiar todos los archivos
COPY . .

# Dar permisos al script de inicio
RUN chmod +x start.sh

# Exponer puertos
EXPOSE 11434 3000

# Comando de arranque
CMD ["/app/start.sh"]
