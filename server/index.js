const express = require('express');
const router = require('../routes');
const db = require('../db');

const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Static files served');
});

app.get('/products', (req, res) => {
  const { page, count } = req.query;
  const SQL = `SELECT * FROM products ORDER BY product_id LIMIT ${count}`;
  db.query(SQL)
    .then( results => {
      res.send(JSON.stringify(results.rows));
      res.end();
    });
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
});


