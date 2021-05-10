const express = require('express');
const cors = require('cors');
const db = require('../db');
const routes = require('./routes');

const app = express();
app.use(cors());
app.use(routes);
const port = 3000;

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
});


