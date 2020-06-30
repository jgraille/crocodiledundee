const mongoose = require('mongoose');
const {Schema} = mongoose;

const bookModel = new Schema(
  {
    title: {type:String},
    isbn: {type:String},
    pageCount: {type:Number},
    categories: {type: String},
  }
);

module.exports = mongoose.model('Book', bookModel)