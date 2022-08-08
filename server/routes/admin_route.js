const express = require('express');
const admin = require('../middlewares/admin_middleware');
const { Product } = require('../models/product_model');
const adminRouter = express.Router();

//Create Admin middleware
adminRouter.post('/admin/add-product', admin, async(req, res) => {
    try{
        const {name, des, price, quantity, category, images} = req.body;
        //Create a Product Model
        let product = new Product({
            //Passing the required objects
            name, 
            des, 
            images, 
            quantity,
            category, 
            price,
        });
        //Save to the database
        product = await product.save();
        //Return product to the client side
        res.json(product);

    }catch(error){
        res.status(500).json({error: error.message });
    }
});

//Get all the products
adminRouter.get('/admin/get-products', admin, async(req, res)=> {
    try{
        const products = await Product.find({}); //Get all the products by define nothing in the find function
        res.json(products);
    }catch(error){
        res.status(500).json({ error: error.message });
    }
});

//Delete the product
adminRouter.post('/admin/delete-product', admin, async (req, res) => {
    try{
        const {id} = req.body;
        let product = await Product.findByIdAndDelete(id);
        res.json(product);
    }catch(error){
        res.status(500).json({ error: error.message });
    }
});

module.exports = adminRouter;

