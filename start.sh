#!/bin/bash
set -e

MODEL="mistral-mini"
PORT="${PORT:-3000}"
OLLAMA_PORT=11434

echo "🚀 Iniciando servidor Ollama..."
ollama serve --host 0.0.0.0 > ollama.log 2>&1 &

# Esperar a que Ollama esté listo
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

# Verificar o descargar el modelo
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
