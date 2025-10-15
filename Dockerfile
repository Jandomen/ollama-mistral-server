# Imagen base oficial de Ollama
FROM ollama/ollama:latest

# Exponemos el puerto
EXPOSE 11434

# Forma exec para CMD, evita problemas con /bin/sh
CMD ["ollama", "serve", "--pull", "mistral"]
