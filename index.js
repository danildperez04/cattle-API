require('dotenv').config({});
const http = require('http');
const app = require('./app');
const config = require('./config');
const PORT = config('port');
const HOST = config('host')

const server = http.createServer(app);


server.listen(PORT, HOST, ()=>{
  console.log(`Server running on port ${PORT}`)
})