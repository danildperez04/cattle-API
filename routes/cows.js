const { Router } = require('express');
const router = Router();
const {
  getCows,
  createCow,
  getSingleCow,
  updateCow,
  deleteCow,
} = require('../controllers/cows');

router.route('/').get(getCows).post(createCow);

router.route('/:id').get(getSingleCow).put(updateCow).delete(deleteCow);

module.exports = router;
