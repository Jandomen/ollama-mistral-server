#!/bin/bash
set -e

MODEL="llama3.2:1b"

echo "🔹 Descargando modelo '$MODEL'..."
ollama pull "$MODEL"

echo "🚀 Iniciando servidor Ollama..."
ollama serve --port 11434 &

# Esperar a que Ollama esté listo
until curl -s http://localhost:11434/api/health > /dev/null; do
  echo "⏳ Esperando a Ollama..."
  sleep 2
done

echo "🌐 Iniciando servidor Node.js..."
exec node server.js
