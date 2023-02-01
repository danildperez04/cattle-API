const express = require('express');
const path = require('path');
const cors = require('cors');
const morgan = require('morgan');
const router = require('./routes');
const notFound = require('./middlewares/notFound');
const errorLogger = require('./middlewares/errorLogger');

const app = express();

//Cross-origin resource sharing
app.use(cors());

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

module.exports = app;
