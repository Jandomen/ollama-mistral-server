FROM ollama/ollama:latest

# Exponemos el puerto
EXPOSE 11434

# Comando de inicio: descargar modelo y luego iniciar servidor
CMD ollama pull mistral && serve
