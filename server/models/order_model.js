const mongoose = require('mongoose');
const { productSchema } = require('./product_model');
const orderSchema = mongoose.Schema({
    userId:{
        type: String, 
        required: true, 
    },
    address:{
        type: String, 
        required: true, 
    },
    products:[
        {
            product: productSchema,
            quantity:{
                type: Number, 
                required: true,
            }
        }
    ],
    totalPrice:{
        type: Number,
        required: true,
    },
    orderedAt:{
        type: Number,
        required: true,
    },
    status:{
        type: Number, 
        default: 0,
    },   
});
const Order = mongoose.model('Order', orderSchema);
module.exports = Order;