FROM ollama/ollama:latest

EXPOSE 11434

# CMD en forma exec, descarga modelo y luego inicia el servidor
CMD ["sh", "-c", "ollama pull mistral && serve"]
