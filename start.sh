#!/bin/sh
set -e

echo "🔹 Iniciando servidor Ollama en segundo plano..."
ollama serve &

# Esperar a que el servidor arranque
sleep 5

echo "🔹 Descargando modelo mistral..."
ollama pull mistral || true

echo "🚀 Servidor listo y modelo cargado."
wait
