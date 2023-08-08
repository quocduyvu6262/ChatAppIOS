//importing modules
const {Sequelize, DataTypes} = require('sequelize')

//database connection
const sequelize = new Sequelize(`postgres://duyvuquoc:Tinodeptrai!13579@localhost:5432/chatapp`)

//check if connection is successful
sequelize.authenticate().then(() => {
    console.log('Connection has been established successfully.')
}).catch(err => {
    console.error('Unable to connect to the database:', err)
})

const db = {}
db.Sequelize = Sequelize
db.sequelize = sequelize

const User = require('./user')(sequelize, DataTypes)
const Message = require('./message')(sequelize, DataTypes)
const Conversation = require('./conversation')(sequelize, DataTypes)

User.hasMany(Message, {
    foreignKey: 'sender_id',
})
Message.belongsTo(User)

Conversation.hasOne(Message, {
  foreignKey: 'convo_id'
});
Message.belongsTo(Conversation);


db.users = User
db.messages = Message
db.conversations = Conversation



module.exports = db

