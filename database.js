const mysql = require('mysql2/promise')
require('dotenv').config();

//Connection to MySQL
const connection = mysql.createPool({
  host: 'localhost',
  port: 3306,
  user: process.env.USER,
  password: process.env.PASSWORD,
  database: process.env.DATABASE
})

//exporting connection
module.exports = connection