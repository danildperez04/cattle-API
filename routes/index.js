const { Router } = require('express');
const router = Router();
const cowsRouter = require('./cows');

router.use('/cows', cowsRouter);

module.exports = router;
