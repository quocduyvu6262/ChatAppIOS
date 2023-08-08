//import modules
const db = require('../models');
const crypto = require('crypto');

const Message = db.messages;
const Conversation = db.conversations;

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

const startConversation = async (user1ID, user2ID) => {
    try{
        const convoID = createConvoID(user1ID, user2ID)
        let conversation = await Conversation.findOne({
            where: {
                id: convoID
            },
            attributes: {
                exclude: ['updatedAt']
            }
        })
        if(!conversation){
            conversation = await Conversation.create({
                id: convoID
            });
        }
        let response = {
            id: conversation.id,
            last_message: conversation.last_message,
            last_seen: conversation.last_seen,
            unseen_count: conversation.unseen_count,
            createdAt: conversation.createdAt
        }
        return response
    } catch (err) {
        console.log(err);
        return null;
    }
};

const createConvoID = (user1ID, user2ID) => {
    const sortedUserIds = [user1ID, user2ID].sort((a, b) => a - b);
  
    // Concatenate the sorted user IDs as a string
    const concatenatedIds = sortedUserIds.join('_');
    
    // Create a unique hash for the concatenated string
    const convoID = crypto.createHash('md5').update(concatenatedIds).digest('hex');
    
    return convoID;
};



module.exports = {
    addMessage,
    getAllMessages,
    startConversation
}