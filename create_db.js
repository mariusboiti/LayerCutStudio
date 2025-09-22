// Script opțional: creează un DB cu 2 tabele simple (fonts, designs) – ÎNCA NU E FOLOSIT
const path = require("path");
const fs = require("fs");
const sqlite3 = require("sqlite3");

const dataDir = path.join(__dirname, "data");
if (!fs.existsSync(dataDir)) fs.mkdirSync(dataDir, { recursive: true });

const dbFile = path.join(dataDir, "app.db");
const db = new sqlite3.Database(dbFile);

db.serialize(() => {
  db.run(`
    CREATE TABLE IF NOT EXISTS fonts (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      family TEXT NOT NULL,
      style TEXT DEFAULT 'Regular',
      weight INTEGER DEFAULT 400,
      file TEXT NOT NULL,
      created_at TEXT DEFAULT (datetime('now'))
    )
  `);

  db.run(`
    CREATE TABLE IF NOT EXISTS designs (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      json TEXT NOT NULL,
      created_at TEXT DEFAULT (datetime('now'))
    )
  `);

  console.log("> DB inițializat la", dbFile);
});

db.close();
