# Imagen base oficial de Ollama
FROM ollama/ollama:latest

# Exponemos el puerto
EXPOSE 11434

# Copiamos el script de inicio
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Usamos el script como entrypoint
CMD ["/start.sh"]