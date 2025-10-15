# Imagen base oficial de Ollama
FROM ollama/ollama:latest

# Exponemos el puerto
EXPOSE 11434

# Descargamos el modelo mistral durante la construcción
RUN ollama pull mistral

# Ejecutamos el comando para iniciar el servidor Ollama
CMD ["serve"]