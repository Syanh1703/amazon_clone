//Create a rating scheme to the product 

const mongoose = require('mongoose');
const ratingSchema = mongoose.Schema({
    userId:{
        //User can change the rating again
        type: String, 
        required: true,
    },
    rating:{
        type: Number, 
        required: true,
    }
});

module.exports = ratingSchema;