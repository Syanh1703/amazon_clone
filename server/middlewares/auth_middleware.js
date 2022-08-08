//Create an admin middle ware
const jwt = require('jsonwebtoken');
const auth = async (req, res, next) => {
    try{
        const token = req.header('x-auth-token');
        if(!token){//Unauthorized error
            return res.status(401).json({ msg: 'No auth token, access denied' });
        }

        const isVerified = jwt.verify(token, 'passwordKey');
        if(!isVerified){
            return res.status(401).json({ msg: 'Token verification failed, authorization denied' });
        }

        //Verify the user
        req.user = isVerified.id; //store the id in the user
        req.token = token;

        //Call the next call back function, which is the next move of the middleware
        next();
    }catch(error){
        res.status(500).json({ error: error.message });
    }
};

module.exports = auth;