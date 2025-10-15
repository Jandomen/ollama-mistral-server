import express from "express";
import fetch from "node-fetch";
import { spawn } from "child_process";

const app = express();
app.use(express.json());

const PORT = process.env.PORT || 3000;
const OLLAMA_PORT = 11434;

// Arrancar Ollama como child process
const ollama = spawn("ollama", ["serve", "--port", OLLAMA_PORT], { stdio: "inherit" });

async function waitForOllama(retries = 20, delay = 2000) {
  for (let i = 0; i < retries; i++) {
    try {
      const res = await fetch(`http://localhost:${OLLAMA_PORT}/api/health`);
      if (res.ok) return true;
    } catch {}
    console.log(`Esperando a que Ollama esté listo... (${i + 1}/${retries})`);
    await new Promise(r => setTimeout(r, delay));
  }
  throw new Error("Ollama no respondió después de varios intentos");
}

// Endpoint de generación de texto
app.post("/api/generate", async (req, res) => {
  try {
    const { model = "llama3.2:1b", prompt } = req.body;
    const response = await fetch(`http://localhost:${OLLAMA_PORT}/api/generate`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ model, prompt }),
    });
    const data = await response.text();
    res.send(data);
  } catch (err) {
    console.error(err);
    res.status(500).send({ error: "Error al conectar con Ollama" });
  }
});

waitForOllama()
  .then(() => {
    app.listen(PORT, () => console.log(`✅ API lista en puerto ${PORT}`));
  })
  .catch(err => {
    console.error(err);
    process.exit(1);
  });
