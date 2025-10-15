import express from "express";
import fetch from "node-fetch";

const app = express();
app.use(express.json());

const OLLAMA_URL = "http://localhost:11434/api/generate";

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
app.listen(PORT, () => console.log(`✅ API lista en el puerto ${PORT}`));
