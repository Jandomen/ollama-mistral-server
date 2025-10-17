#!/bin/bash
set -e

MODEL="${MODEL:-tinyllama:1.1B}"
PORT="${PORT:-3000}"
OLLAMA_PORT="${OLLAMA_PORT:-11434}"

echo "🚀 Iniciando servidor Ollama en puerto $OLLAMA_PORT..."
ollama serve --port $OLLAMA_PORT > ollama.log 2>&1 &

# Esperar a Ollama
timeout=60
count=0
until curl -s http://localhost:${OLLAMA_PORT}/api/health > /dev/null; do
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

# Verificar o descargar modelo
echo "🔹 Verificando si el modelo '$MODEL' ya está descargado..."
if ! ollama list | grep -q "$MODEL"; then
  echo "⬇️ Descargando modelo '$MODEL'..."
  ollama pull "$MODEL"
else
  echo "✅ Modelo '$MODEL' ya disponible"
fi

# Iniciar Node.js
echo "🌐 Iniciando servidor Node.js en puerto $PORT..."
exec node server.js
