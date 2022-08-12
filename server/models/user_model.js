const mongoose = require('mongoose');
const { productSchema } = require('./product_model');

const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,
    },
    email: {
        required:true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                //Match some certain criteria
                //Use Regex
                const emailRegex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
                return value.match(emailRegex);
            },
            //If the validate false
            message: 'Please enter a valid email',
        },
    },

    pass: {
        required: true,
        type: String,
        validate: {
            validator: (value) => {
                return value.length > 7 ;
            },
            //If the validate false
            message: 'Please enter a stronger password',
        },
    },

    address: {
        type: String,
        default: '',
    },

    type: {
        type: String,
        default: 'user',
    },

    //cart
    cart: [
       {
            product : productSchema,
            quantity: {
                type: Number, 
                required: true,
            }
       },
    ],
});

const user = mongoose. model('User', userSchema);
module.exports = user;