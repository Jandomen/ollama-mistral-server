#!/bin/sh
set -e

echo "🔹 Descargando modelo mistral..."
ollama pull mistral || true

echo "🚀 Iniciando servidor Ollama..."
serve
