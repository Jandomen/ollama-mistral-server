# Ollama + Mistral (Backend)

Servidor Docker con Ollama y modelo Mistral, listo para desplegar en Render.

## 🚀 Cómo desplegar
1. Subir este repositorio a GitHub.
2. Conectar en [Render.com](https://render.com/new).
3. Render detectará automáticamente el Dockerfile.
4. Puerto: 11434

## 🧪 Probar la API
```bash

curl https://ollama-llama-server.onrender.com/api/generate -d '{
  "model": "llama3.2:1b",
  "prompt": "Dame una frase motivadora sobre la programación."
}'


