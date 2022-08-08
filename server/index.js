//Localhost: 127.0.0.1
//Create the first API by Node JS
const PORT = 3000;
const express = require('express');
const app = express();

//Establish the database
const mongoose = require('mongoose');
const adminRouter = require('./routes/admin_route');
const mongoUrl = 'mongodb+srv://syanh:Lamgicomahoi123@cluster0.e5expdz.mongodb.net/?retryWrites=true&w=majority';

//Connection
mongoose.connect(mongoUrl).then(()=> {
    console.log('Connection to Mongo DB successful');
}).catch(error => {
    console.log(error);
});

//Import from the other file
const authRouter = require('./routes/auth_route');
const productRouter = require('./routes/product_route');
const userRouter = require('./routes/user_route');

//Add some middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

//Listen to the connection
app.listen(PORT,() => {
    console.log('Connected  at port: ' + PORT);
});


