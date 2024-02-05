const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');
const User = require('./user_schema'); // Assuming you have a user model

const app = express();
const port = 3000;

app.use(cors());
app.use(bodyParser.json());

mongoose.connect('mongodb://localhost:27017/pawnshop', { useNewUrlParser: true, useUnifiedTopology: true });

// Define the route to add a user mongodb://localhost:27017
app.post('/adduser', async (req, res) => {
  try {
    const userData = req.body;

    // Create a new user using the User model
    const newUser = new User(userData);

    // Save the user to the database
    await newUser.save();

    res.status(201).json({ message: 'User added successfully' });
  } catch (error) {
    console.error('Error adding user:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
