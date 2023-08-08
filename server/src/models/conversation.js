//define message
module.exports = (sequelize, DataTypes) => {
    const Conversation = sequelize.define('Conversation', {
        id: {
            type: DataTypes.STRING(50),
            primaryKey: true,
        },
        last_message: {
            type: DataTypes.INTEGER,
            allowNull: true,
            references:{
                model: 'Message',
                key: 'id'
            }
        },
        last_seen: {
            type: DataTypes.BOOLEAN,
            allowNull: true,
        },
        unseen_count: {
            type: DataTypes.INTEGER,
            allowNull: true,
        }
    },{
        tableName: "Conversation",
        timestamps: true,
    });
    return Conversation;
}