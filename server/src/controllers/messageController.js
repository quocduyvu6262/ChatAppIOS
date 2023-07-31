//import modules
const db = require('../models');

const Message = db.messages;

//function to add message to database
const addMessage = async (messageBody) => {
    try {
        const {
            sender_id,
            username,
            text 
        } = messageBody;
        const message = await Message.create(messageBody);
        if (message){
            console.log("Message sent to database successfull.");
            return message;
        } else {
            console.log("Failed to send message to database");
            return;
        }
    } catch (err) {
        console.log("Failed to send message to database");
        console.log(err);
    }
};

//function to get previous messages 
const getAllMessages = async (req, res) => {
    try {
        const messages = await Message.findAll({
            attributes: {
                exclude: ['updatedAt']
            }
        });
        if (messages){
            console.log("Fetch messages successfully.");
            res.status(200).json(messages);
        } else {
            res.status(404).send("Failed to fetch previous messages");
            console.log("Failed to fetch previous messages");
        }
    } catch (err) {
        console.log("Failed to fetch previous messages");
    }
}



module.exports = {
    addMessage,
    getAllMessages
}