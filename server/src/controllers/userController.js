//import modules
const db = require('../models');

const User = db.users;


const getUsers = async (req, res) => {
    try{
        const users = await User.findAll({
            attributes: {
                exclude: ['password'],
            }
        });
        if (users) {
            console.log("Fetch all users successfully.");
            res.status(200).json(users);
        } else {
            console.log("Fetch all users failed.");
            return res.status(409).send("Fetch all users failed.");
        }
    } catch(err){
        console.log(err);
        return res.status(500).send("Server error");
    }
};

module.exports = {
    getUsers
};