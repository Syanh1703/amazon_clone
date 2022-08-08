const express = require('express');
const User = require('../models/user_model');
const auth_middleware = require('../middlewares/auth_middleware');
const jwt = require('jsonwebtoken');

//Secure the password
const bcryptjs = require('bcryptjs');

//Create a router
const authRouter = express.Router();
authRouter.get('/user', (req, res) => {
    res.json({
        msg: 'Sy Anh'
    });
});

//SIGN UP
authRouter.post('/api/signup', async (req, res) => {
    try{
        const {name, email, pass} = req.body;
        const existingUser = await User.findOne({ email });
        if(existingUser){
            //already have that user
            return res.status(400).json({// Avoid status code
                msg: 'User with the same email',
            });
        }

        const hashedPass = await bcryptjs.hash(pass, 8);
    
        //Create User model
        let user = new User({
           email,
           pass: hashedPass,
           name,
        });
        user = await user.save();
        res.json(user);
    }catch(error){
        res.status(500).json({ error: error.message });
    }
    //Get the data from the client
    //Post the data into the database
    //Return the data to the user

});

//SIGN IN
authRouter.post('/api/signin', async (req, res) => {
   try{
     const { email, pass } = req.body;

     const user = await User.findOne({ email });
     if(!user){ //Validation
        return res.status(400).json({ msg: 'User with this email does not exist '});
     }

     //Check password matching
     const isMatched = await bcryptjs.compare(pass, user.pass);
     if(!isMatched){
        return res.status(400).json({ msg: 'Incorrect password' });
     }

     //Use jwt
     const token = jwt.sign({ id: user._id }, "passwordKey");
     res.json({ token, ...user._doc })
   }catch(error){
      res.status(500).json({ error: error.message });
   }
})

//POST UER DATA BY TOKEN
authRouter.post('/validToken', async (req, res) => {
    try{
        const token = req.header('x-auth-token');
        if(!token){//check token is null or not
            return res.json(false);
        }
        const isVerified = jwt.verify(token, 'passwordKey');

        //Check if the token is verified or not
        if(!isVerified){
            return res.json(false);
        }

        //Check if the user available
        const existedUser = await User.findById(isVerified.id);
        if(!existedUser){
            return res.json(false);
        }

        res.json(true);

    } catch(error){
        res.status(500).json({ error: error.message });
    }
})

//GET USER DATA
authRouter.get('/', auth_middleware, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token });
});//This auth is a middleware

module.exports = authRouter;