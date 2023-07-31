const express = require('express')
const sequelize = require('sequelize')
const dotenv = require('dotenv').config()
const socketIO = require('socket.io')
const cookieParser = require('cookie-parser')
const db = require('./models')
const {addMessage} = require('./controllers/messageController')
const authRoutes = require('./routes/authRoutes')
const userRoutes = require('./routes/userRoutes')
const messageRoutes = require('./routes/messageRoutes')


//setting up your port
const PORT = process.env.PORT || 3001

//assigning the variable app to express
const app = express()

//middleware
app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(cookieParser())

//synchronizing the database and forcing it to false so we dont lose data
db.sequelize.sync({ force: false }).then(() => {
    console.log("db has been re sync")
})

//routes for the user API
app.use('/api/auth', authRoutes)
app.use('/api/users', userRoutes)
app.use('/api/messages', messageRoutes)

//listening to server connection
//create the Socket.IO server after starting the app
const  server = app.listen(PORT, () => console.log(`Server is connected on ${PORT}`))
const io = socketIO(server)

io.on('connection', (socket) => {
    console.log('User connected.')

    socket.on('sendMessage', async (messageBody) =>{
        const parsedMessage = JSON.parse(messageBody)
        const message = await addMessage(parsedMessage)
        io.emit('receiveMessage', message.id, message.sender_id, message.username, message.text, message.createdAt)
    })

    socket.on('Disconnected from chat', () => {
        console.log('User disconnected')
    })
})