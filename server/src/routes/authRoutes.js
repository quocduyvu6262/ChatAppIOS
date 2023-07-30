const express = require('express');
const {login, signup} = require('../controllers/authController');
const {saveuser} = require('../middlewares/authMiddleware');

const router = express.Router();


router.post('/signup', saveuser, signup);
router.post('/login', login);

module.exports = router;
