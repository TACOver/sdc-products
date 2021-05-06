const db = require('../db');
const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Static files served');
});

app.get('/products', (rew, res) => {
  db.query('SELECT * FROM products')
  .then(results => {
    res.send(JSON.stringify(results));
  })
  .catch(err => {
    console.log('ERROR: ', err);
    res(JSON.stringify(err));
  });
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
});


