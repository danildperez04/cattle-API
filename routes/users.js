const { Router } = require('express');
const router = Router();
const {
    getUsers,
    createUser,
    getSingleUser,
    updateUser,
    deleteUser
} = require('../controllers/users');


router.route('/').get(getUsers).post(createUser);
router.route('/:id').get(getSingleUser).put(updateUser).delete(deleteUser);

module.exports = router;