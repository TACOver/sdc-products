const Pool = require('pg').Pool
const pool = new Pool({
  user: 'tamir',
  host: 'localhost',
  database: 'sdcproducts',
  password: 'password',
  port: 5432,
});

pool.query('SELECT * FROM products WHERE product_id=1', (error, results) => {
  if (error) {
    throw error
  }
  console.log(results.rows);
})
