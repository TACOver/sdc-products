const Router = require('express-promise-router');
const db = require('../db');
const router = new Router();
module.exports = router;

router.get('/products', async (req, res) => {
  const { rows } = await db.query('SELECT * FROM products');
  res.send(rows);
});
