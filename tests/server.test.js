const request = require('supertest');
const app = require('../server/app');
const db = require('../db');

describe('Products route', () => {
  it('should get 5 products on a products fetch with no parameters', () => {
    request(app)
      .get('/products')
      .expect(200)
      .expect(res => {
        res.body.length = 6;
      });
  });

  it('should get the correct number of products on fetch with count parameter', () => {
    request(app)
      .get('/products?count=4')
      .expect(200)
      .expect(res => {
        res.body.length = 4;
      });
  });

  it('should get one product on /products/:productId fetch', () => {
    request(app)
      .get('/products/2')
      .expect(200)
      .expect(res => {
        res.body.length = 1;
      });
  });

  it('should get 4 related items for a product', (done) => {
    request(app)
      .get('/products/2/related')
      .expect(200)
      .expect(res => {
        res.body.length = 6;
      }, done);
  });
});



// db.pool.end();