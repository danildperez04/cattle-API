const mysql = require('mysql2/promise');
const { db } = require('./config');

const pool = mysql.createPool({
  host: db.host,
  port: db.port,
  user: db.user,
  password: db.password,
  database: db.name,
});

module.exports = pool;
