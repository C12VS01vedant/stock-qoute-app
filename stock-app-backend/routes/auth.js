const express = require('express');
const router = express.Router();
const { signup, login, logout } = require('../controllers/authController');
const { validateSignup, validateLogin } = require('../middlewares/validation');
const { authenticateToken } = require('../middlewares/auth');
const User = require('../models/User');

// Auth routes
router.post('/signup', validateSignup, signup);
router.post('/login', validateLogin, login);
router.post('/logout', authenticateToken, logout);

// Get current user route
router.get('/me', authenticateToken, async (req, res) => {
  try {
    const user = await User.findById(req.user.id).select('-password');
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }
    res.json(user);
  } catch (error) {
    res.status(500).json({ message: 'Server error', error: error.message });
  }
});

module.exports = router;