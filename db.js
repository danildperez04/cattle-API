const { createPool } = require('mysql2/promise');
const { db } = require('./config');

const pool = createPool({
  host: db.host,
  port: db.port,
  user: db.user,
  password: db.password,
  database: db.name,
});

module.exports = pool;
