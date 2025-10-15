#!/bin/sh
set -e

echo "🚀 Iniciando servidor Ollama..."
ollama serve &

# Espera a que el servidor se inicie
sleep 5

echo "🔹 Descargando modelo mistral..."
ollama pull mistral || true

echo "✅ Servidor listo y modelo cargado. Manteniendo el proceso activo..."
wait
