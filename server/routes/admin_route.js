const express = require('express');
const { PromiseProvider } = require('mongoose');
const admin = require('../middlewares/admin_middleware');
const Order = require('../models/order_model');
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

//Get all the orders
adminRouter.get('/admin/get-orders', admin, async(req, res) => {
    try {
        const orders = await Order.find({});
        res.json(orders);
      } catch (e) {
        res.status(500).json({ error: e.message });
      }
});

//Change order status
adminRouter.post('/admin/change-order-status', admin, async (req, res) => {
    try{
        const { id, status } = req.body;
        let order = await Order.findById(id);
        order.status = status;
        order = await order.save();
        res.json(order);
    }catch(error){
        res.status(500).json({ error: error.message });
    }
});

//Analytics page
adminRouter.get('/admin/analytics', admin, async (req, res) => {
    try {
        const orders = await Order.find({});
        let totalEarnings = 0;
    
        for (let i = 0; i < orders.length; i++) {
          for (let j = 0; j < orders[i].products.length; j++) {
            totalEarnings +=
              orders[i].products[j].quantity * orders[i].products[j].product.price;
          }
        }
        // CATEGORY WISE ORDER FETCHING
        let mobileEarnings = await fetchCategoryWiseProduct("Mobiles");
        let essentialEarnings = await fetchCategoryWiseProduct("Essentials");
        let applianceEarnings = await fetchCategoryWiseProduct("Appliances");
        let booksEarnings = await fetchCategoryWiseProduct("Books");
        let fashionEarnings = await fetchCategoryWiseProduct("Fashion");
        let electronicsEarnings = await fetchCategoryWiseProduct("Electronics");

        console.log('Elec:' + electronicsEarnings + ', mobile: ' + mobileEarnings + ', essentials: ' + essentialEarnings);
    
        let earnings = {
          totalEarnings,
          mobileEarnings,
          essentialEarnings,
          applianceEarnings,
          booksEarnings,
          fashionEarnings,
          electronicsEarnings
        };
    
        res.json(earnings);
      } catch (e) {
            res.status(500).json({ error: e.message });
      }
});

async function fetchCategoryWiseProduct(category){
    //Find the category of each order
    let earning = 0;
    let categoryOrders = await Order.find({
        'products.product.category' : category,
    });

    for(let i = 0; i < categoryOrders.length; i++){
        for(let j = 0; j < categoryOrders[i].products.length; j++){
            earning += categoryOrders[i].products[j].product.price * categoryOrders[i].products[j].quantity;
        }
    }
    return earning;
}

module.exports = adminRouter;

