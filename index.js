const express = require('express');
const path = require('path');
require('dotenv').config({});
const { host, port } = require('./config');
const morgan = require('morgan');
const router = require('./routes');
const notFound = require('./middlewares/notFound');
const errorLogger = require('./middlewares/errorLogger');

const app = express();

//Statics
app.use(express.static(path.join(__dirname, 'client/dist')));

//Middlewares
app.use(express.json());
app.use(morgan('dev'));

//Routing
app.use('/api/v1', router);

app.use(notFound);

//Errors
app.use(errorLogger);

app.listen(port, host, () => {
  console.log(`Server running on ${port}`);
});
