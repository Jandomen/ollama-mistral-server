FROM ollama/ollama:latest

# Expone el puerto de Ollama
EXPOSE 11434

# Copia el script de inicio
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Anula el ENTRYPOINT de la imagen base de Ollama
ENTRYPOINT []

# Usa el script como comando de inicio
CMD ["/start.sh"]
