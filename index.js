const express = require('express');
const morgan = require('morgan');
const router = require('./routes');
const notFound = require('./middlewares/notFound');
const errorLogger = require('./middlewares/errorLogger');

const PORT = process.env.PORT || 3000;
const app = express();

//Middlewares
app.use(express.json());
app.use(morgan('dev'));

//Routing
app.use('/api/v1', router);

app.use(notFound);

//Errors
app.use(errorLogger);

app.listen(PORT, () => {
  console.log(`Server running on ${PORT}`);
});
