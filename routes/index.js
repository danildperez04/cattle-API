const { Router } = require('express');
const router = Router();
const cowsRouter = require('./cows');
const usersRouter = require('./users')

router.use('/cows', cowsRouter);
router.use('/users', usersRouter);

module.exports = router;
