const mongoose = require('mongoose');
const ratingSchema = require('./rating_model');
const productSchema = mongoose.Schema({
    //Define Schema
    name:{
        type: String, 
        required: true,
        trim: true,
    },
    des:{
        type: String, 
        required: true,
        trim: true,
    },
    quantity:{
        type: Number, 
        required: true,
    },
    price:{
        type: Number,
        required:true,
    },
    category:{
        type: String, 
        required: true,
        trim: true,
    },
    images:[
        {
            type:String, 
            required: true,
        }
    ],

    //ratings
    ratings:[ratingSchema],
});

const Product = mongoose.model('Product', productSchema);
module.exports = {Product, productSchema};
