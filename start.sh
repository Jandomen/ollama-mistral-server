#!/bin/bash
set -e

MODEL="llama3.2:1b"

echo "🚀 Iniciando servidor Ollama..."
ollama serve > ollama.log 2>&1 &

# Esperar a que Ollama esté listo antes de continuar
timeout=60
count=0
until curl -s http://localhost:11434/api/health > /dev/null; do
  if [ $count -ge $timeout ]; then
    echo "❌ Timeout esperando Ollama"
    cat ollama.log
    exit 1
  fi
  echo "⏳ Esperando a Ollama... (${count}s)"
  sleep 2
  ((count+=2))
done
echo "✅ Servidor Ollama listo"

# Verifica si el modelo ya existe
if ! ollama list | grep -q "$MODEL"; then
  echo "🔹 Descargando modelo '$MODEL'..."
  ollama pull "$MODEL"
else
  echo "✅ Modelo '$MODEL' ya está disponible"
fi

echo "🌐 Iniciando servidor Node.js en puerto $PORT..."
exec node server.js