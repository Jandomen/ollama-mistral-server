#!/bin/bash
set -e

MODEL="llama3.2:1b"

# Verifica si el modelo ya existe para evitar descargas redundantes
if ! ollama list | grep -q "$MODEL"; then
  echo "🔹 Descargando modelo '$MODEL'..."
  ollama pull "$MODEL"
else
  echo "✅ Modelo '$MODEL' ya está disponible"
fi

echo "🚀 Iniciando servidor Ollama..."
ollama serve --port 11434 &

# Esperar a que Ollama esté listo
timeout=60
count=0
until curl -s http://localhost:11434/api/health > /dev/null; do
  if [ $count -ge $timeout ]; then
    echo "❌ Timeout esperando Ollama"
    exit 1
  fi
  echo "⏳ Esperando a Ollama... (${count}s)"
  sleep 2
  ((count++))
done

echo "🌐 Iniciando servidor Node.js en puerto $PORT..."
exec node server.js