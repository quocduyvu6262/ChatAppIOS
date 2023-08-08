const express = require('express');
const {getAllMessages, startConversation} = require('../controllers/messageController');

const router = express.Router();

router.get('/', getAllMessages);

module.exports = router;
