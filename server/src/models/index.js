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

db.users = require('./user')(sequelize, DataTypes)

module.exports = db

