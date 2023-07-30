//import modules
const bcrypt = require("bcrypt");
const db = require('../models');
const jwt = require('jsonwebtoken');

const User = db.users;

//function to sign a user up
const signup = async (req, res) => {
    try{
        const {username, email, password} = req.body;
        const data = {
            username,
            email,
            password: await bcrypt.hash(password, 10)
        }
        const user = await User.create(data);
        if (user){
            let token = jwt.sign({id: user.id}, process.env.SECRET_KEY, {
                expiresIn: 1 * 24 * 60 * 60 * 1000 
            });

            res.cookie("jwt", token, { maxAge: 1 * 24 * 60 * 60, httpOnly: true });
            console.log("user", JSON.stringify(user, null, 2));
            console.log(token);

            return res.status(200).send({
                id: user.id,
                username: user.username,
                email: user.email,
                token,
                message: "Sign in successfully",
                success: true
            });
        } else {
            console.log("Sign in failed.");
            return res.status(409).send("Details are not correct");
        }
    } catch (err) {
        console.log(err);
        return res.status(500).send("Server error");
    }
};

//function to sign a user in
const login = async (req, res) => {
    try{
        const {email, password} = req.body;
        const user = await User.findOne({where: {email}});

        if (user && bcrypt.compareSync(password, user.password)){
            let token = jwt.sign({id: user.id}, process.env.SECRET_KEY, {
                expiresIn: 1 * 24 * 60 * 60 * 1000 
            });

            res.cookie("jwt", token, { maxAge: 1 * 24 * 60 * 60, httpOnly: true });
            console.log("user", JSON.stringify(user, null, 2));
            console.log(token);

            return res.status(200).send({
                id: user.id,
                username: user.username,
                email: user.email,
                token,
                message: "Logged in successfully",
                success: true
            });
        } else {
            console.log("Authentication failed.");
            return res.status(409).send("Authentication failed.");
        }
    } catch(err){
        console.log(err);
        return res.status(500).send("Server error");
    }
}

module.exports = {
    signup,
    login
}