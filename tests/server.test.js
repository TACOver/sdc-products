const request = require('supertest');
const cors = require('cors');
const express = require('express');

const app = express();
const routes = require('../server/routes')(app);
app.use(cors());

describe('Products route', () => {

  it('should get 5 products on a products fetch with no parameters', () => {
    request(app)
      .get('/products')
      .expect(200)
      .expect(res => {
        res.body.length = 5;
      })
      .end(function(err, res) {
        if (err) throw err;
      });
  });
  it('should get the correct number of products on fetch with count parameter', () => {
    request(app)
      .get('/products?count=4')
      .expect(200)
      .expect(res => {
        res.body.length = 4;
      })
      .end(function(err, res) {
        if (err) throw err;
      });
  });
});