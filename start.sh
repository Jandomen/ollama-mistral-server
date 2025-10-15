#!/bin/bash
set -e

MODEL="llama3.2:1b"

echo "🔹 Descargando modelo '$MODEL'..."
ollama pull "$MODEL"

echo "🚀 Iniciando servidor Ollama..."
ollama serve --port 11434 &

sleep 10

echo "🌐 Iniciando servidor Node.js..."
node server.js
