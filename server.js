const express = require('express');
const path = require('path');
const fs = require('fs');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

// load data
const DATA_FILE = path.join(__dirname, 'data', 'dishes.json');

function loadData() {
  try {
    const raw = fs.readFileSync(DATA_FILE, 'utf8');
    return JSON.parse(raw);
  } catch (err) {
    console.error('Failed to load data:', err);
    return [];
  }
}

app.get('/api/health', (req, res) => {
  res.json({ status: 'ok', app: 'cloud-kitchen' });
});

app.get('/api/states', (req, res) => {
  const data = loadData();
  res.json(data);
});

app.get('/api/states/:slug', (req, res) => {
  const slug = req.params.slug.toLowerCase();
  const data = loadData();
  const entry = data.find(e => e.slug === slug);
  if (!entry) return res.status(404).json({ error: 'State not found' });
  res.json(entry);
});

// serve static frontend
app.use(express.static(path.join(__dirname, 'public')));

// fallback to index.html for SPA
app.get('*', (req, res) => {
  const indexPath = path.join(__dirname, 'public', 'index.html');
  if (fs.existsSync(indexPath)) return res.sendFile(indexPath);
  res.status(404).send('Not found');
});

app.listen(PORT, () => {
  console.log(`Cloud Kitchen server listening on port ${PORT}`);
});
