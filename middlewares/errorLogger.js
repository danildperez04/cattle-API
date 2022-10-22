const errorLogger = (err, req, res, next) => {
  console.log(err.message);
};

module.exports = errorLogger;
