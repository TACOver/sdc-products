const request = require('supertest');
const app = require('../server/app');
const db = require('../db');

describe('Products route', () => {
  afterAll(() => {
    db.pool.end();
  });

  it('should get 5 products on a products fetch with no parameters', async () => {
    await request(app)
      .get('/products')
      .expect(200)
      .expect(res => {
        res.body.length = 5;
      });
  });

  it('should get the correct number of products on fetch with count parameter', async () => {
    await request(app)
      .get('/products?count=4')
      .expect(200)
      .expect(res => {
        res.body.length = 4;
      });
  });
});
