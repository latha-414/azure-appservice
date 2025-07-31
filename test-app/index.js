const express = require('express');
const app = express();

// ✅ Use the PORT from Azure's environment
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('Hello from Dockerized Node.js app!');
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});
