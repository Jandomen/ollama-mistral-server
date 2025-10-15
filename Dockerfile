FROM ollama/ollama:latest

# Exponer puerto
EXPOSE 11434

# Copiar script de inicio
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Anular el ENTRYPOINT predeterminado
ENTRYPOINT []

# Comando de inicio
CMD ["/start.sh"]
