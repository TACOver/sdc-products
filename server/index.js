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
      res.status(200);
      res.send(results.rows);
      res.end();
    });
});


app.get('/products/:productId', (req, res) => {
  const SQL = 
    `
      SELECT product_id, product_name, slogan, product_description, category, default_price,
      jsonb_agg (jsonb_build_object('name', features.feature_name, 'value', features.feature_value )) features
      FROM products 
      INNER JOIN features USING (product_id) 
      WHERE product_id=${req.params.productId}
      GROUP BY product_id
    `;
  db.query(SQL)
    .then( results => {
      res.status(200);
      res.send(results.rows);
      res.end();
    });
});

app.get('/products/:productId/styles', (req, res) => {
  const SQL = 
    `
      SELECT styles.style_id, style_name, original_price, sale_price, isdefault,
      jsonb_agg (jsonb_build_object('thumbnail_url',photos.thumbnail,'url',photos.url)) photos,
      FROM styles
      LEFT JOIN photos ON styles.style_id = photos.style_id
      WHERE product_id=${req.params.productId}
    `;
    // SELECT styles.style_id, style_name, original_price, sale_price, isdefault,
    //   jsonb_agg (jsonb_build_object('thumbnail_url',1,'url',2)) photos,
    //   jsonb_agg (jsonb_build_object('name',1)) skus
    //   FROM styles
    //   LEFT JOIN photos USING style_id
  db.query(SQL)
    .then( results => {
      res.send(results.rows);
      res.end();
    })
    .catch( err => {
      res.status(400);
      res.end();
      console.log(err);
    });
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
});


