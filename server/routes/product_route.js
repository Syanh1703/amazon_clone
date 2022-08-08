//Fetch the products from certain category
const express = require('express');
const productRouter = express.Router();
const auth = require('../middlewares/auth_middleware');
const { Product } = require('../models/product_model');


//api that client have to enter: /api/products?category=Essentials

productRouter.get('/api/products', auth, async(req, res)=> {
    try{
        console.log(req.query.category);
        const products = await Product.find({ category: req.query.category });
        res.json(products);
    }catch(error){
        res.status(500).json({ error: error.message });
    }
});

//Create a request to search for the product
productRouter.get('/api/products/search/:name', auth, async(req, res) => {
    try{
        console.log(req.params.search);
        const products = await Product.find({
            name: { $regex: req.params.name, $options: 'i' },
        });
        res.json(products);
    }catch(error){
        res.status(500).json({ error: error.message });
    }
})

//Create a post request route to rate the product
productRouter.post('/api/rate-product', auth, async(req, res)=> {
    try{
        const {id, rating} = req.body;
        let product = await Product.findById(id);

        //Add, remove or rating
        for(let i = 0; i<product.ratings.lenght; i++){
            if(product.ratings[i].userId == req.user){
                product.ratings.splice(i,1);
                break;
            }
        };

        const ratingSchema = {
            userId: req.user,
            rating,
        }

        product.ratings.push(ratingSchema);
        product = await product.save();
        res.json(product);
    }catch(error){
        res.status(500).json({ error: error.message })
    }
})

//Create getter for deal of the day
productRouter.get('/api/deal-of-the-day', auth, async (req, res) => {
    //Product with highest rating will be on deal of the day
    try{
        let products = await Product.find({});
        products = products.sort((pro1, pro2) => {
            let pro1Sum = 0;
            let pro2Sum = 0;
            for(let i = 0; i<pro1.ratings.length; i++){
                pro1Sum += pro1.ratings[i].rating;
            }

            for(let i = 0; i<pro2.ratings.length; i++){
                pro2Sum += pro2.ratings[i].rating;
            }
            
            return pro1Sum < pro2Sum ? 1 : -1;
        });

        res.json(products[0]);
    }catch(error){
        res.status(500).json({ error: error.message });
    }
})

module.exports = productRouter;