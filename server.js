// server.js
const express = require('express');
const path = require('path');
const compression = require('compression');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(compression());

// servește tot ce este în /public (inclusiv /assets, etc.)
app.use(express.static(path.join(__dirname, 'public'), { extensions: ['html'] }));

// ruta rădăcină -> public/index.html
app.get('/', (_req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(PORT, () => {
  console.log(`Ready -> http://localhost:${PORT}`);
});
