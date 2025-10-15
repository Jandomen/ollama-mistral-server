# Imagen base oficial de Ollama
FROM ollama/ollama:latest

# Exponemos el puerto
EXPOSE 11434

# Inicia Ollama y descarga el modelo al mismo tiempo
CMD ollama serve --pull mistral
