# Imagen base oficial de Ollama
FROM ollama/ollama:latest

# Descarga el modelo Mistral
RUN ollama pull mistral

# Expone el puerto donde correrá Ollama
EXPOSE 11434

# Inicia Ollama
CMD ["serve"]
