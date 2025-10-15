#!/bin/bash
set -e

MODEL="llama3.2:1b"

echo "🔹 Descargando modelo '$MODEL'..."
ollama pull "$MODEL"

echo "🚀 Iniciando servidor Ollama..."
# Ejecutar en foreground con exec para que Docker lo controle
exec ollama serve --port 11434 &

# Esperar a que Ollama esté listo
sleep 10

echo "🌐 Iniciando servidor Node.js..."
exec node server.js
