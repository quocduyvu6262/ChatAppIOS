//import modules
const express = require('express');
const db = require('../models');

const User = db.users;

//function to check if user exists
const saveuser = async (req, res, next) => {
    try{
        const username = await User.findOne({
            where: {
                username: req.body.username
            }
        })
        if (username) {
            return res.json(409).send("Username already taken.");
        }

        const email = await User.findOne({
            where: {
                email: req.body.email
            }
        });
        if (email) {
            return res.json(409).send("Authentication failed.");
        }

        next();
    } catch (err) {
        console.log(err);
    }
};

module.exports = {
    saveuser
};


