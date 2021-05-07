const express = require('express');
const db = require('../db');

const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Static files served');
});

app.get('/products', (req, res) => {
  const { page, count } = req.query;
  let pageOffset = 0;
  let SQL = 'SELECT * FROM products';
  // if (page) {
  //   if (!parseInt(page)) {
  //     res.status(422);
  //     res.end();
  //   } else {
  //     pageOffset = (parseInt(page) - 1) * 100;
  //   }
  // }
  if (count) {
    if (!parseInt(count)) {
      res.status(422);
      res.end();
    } else {
      SQL += ` LIMIT ${count}`;
    }
  } else {
    SQL += ' LIMIT 5';
  }
  db.query(SQL)
    .then( results => {
      res.send(results.rows);
      res.end();
    });
});


app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
});


