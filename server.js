import express from 'express';
import cors from 'cors';
import Database from 'better-sqlite3';
import path from 'path';
import fs from 'fs';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// === Codex Patch: servește fișierele statice din folderul public ===
const app = express();
const PORT = process.env.PORT || 3000;

// middleware utile
app.use(cors());
app.use(express.json());

// fișiere statice
app.use(express.static(path.join(__dirname, 'public')));

// fallback: orice alt request returnează index.html
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// pornește serverul
app.listen(PORT, () => {
  console.log(`✅ LayerCut Studio server running at http://localhost:${PORT}`);
});
