import express from "express";
import fetch from "node-fetch";

const app = express();
app.use(express.json());

const OLLAMA_URL = "http://localhost:11434/api/generate";

// Función para esperar a Ollama
async function waitForOllama(retries = 10, delay = 2000) {
  for (let i = 0; i < retries; i++) {
    try {
      const res = await fetch(`${OLLAMA_URL}/health`);
      if (res.ok) return true;
    } catch {}
    console.log(`Esperando a que Ollama esté listo... (${i + 1}/${retries})`);
    await new Promise(r => setTimeout(r, delay));
  }
  throw new Error("Ollama no respondió después de varios intentos");
}

// Endpoint para generar texto
app.post("/api/generate", async (req, res) => {
  try {
    const { model = "llama3.2:1b", prompt } = req.body;
    const response = await fetch(OLLAMA_URL, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ model, prompt }),
    });
    const data = await response.text();
    res.send(data);
  } catch (error) {
    console.error("Error:", error);
    res.status(500).send({ error: "Error al conectar con Ollama." });
  }
});

const PORT = process.env.PORT || 3000;

waitForOllama()
  .then(() => {
    app.listen(PORT, () => console.log(`✅ API lista en el puerto ${PORT}`));
  })
  .catch(err => {
    console.error(err);
    process.exit(1);
  });
