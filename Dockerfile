# Imagen base oficial de Ollama
FROM ollama/ollama:latest

# Exponemos el puerto
EXPOSE 11434

# Solo pasamos los argumentos al entrypoint de Ollama
CMD ["serve", "--pull", "mistral"]
