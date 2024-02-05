const mongoose = require('mongoose');

const productSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
  },
  title: {
    type: String,
    required: true,
  },
  price: {
    type: Number,
    required: true,
  },
  negotiable: {
    type: Boolean,
    default: false,
  },
  image: {
    type: Buffer, // Assuming you'll store the image data as Buffer
  },
  description: {
    type: String,
  },
  dateOfPost: {
    type: Date,
    default: Date.now,
  },
});

const Product = mongoose.model('Product', productSchema);

module.exports = Product;
