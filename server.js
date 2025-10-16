import express from "express";
import fetch from "node-fetch";

const app = express();
app.use(express.json());

const PORT = process.env.PORT || 3000;
const OLLAMA_PORT = 11434;

app.get("/health", (req, res) => res.status(200).send("OK"));

app.post("/api/generate", async (req, res) => {
  try {
    const { model = "mistral-mini", prompt } = req.body;
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

async function waitForOllama(retries = 30, delay = 2000) {
  for (let i = 0; i < retries; i++) {
    try {
      const res = await fetch(`http://localhost:${OLLAMA_PORT}/api/health`);
      if (res.ok) return true;
    } catch {}
    console.log(`⏳ Esperando a Ollama... (${i + 1}/${retries})`);
    await new Promise(r => setTimeout(r, delay));
  }
  throw new Error("Ollama no respondió después de varios intentos");
}

waitForOllama()
  .then(() => {
    app.listen(PORT, () => console.log(`✅ API lista en puerto ${PORT}`));
  })
  .catch((err) => {
    console.error(err);
    process.exit(1);
  });
