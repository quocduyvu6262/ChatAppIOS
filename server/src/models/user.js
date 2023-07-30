//define user
module.exports = (sequelize, DataTypes) => {
    const User = sequelize.define('User', {
        id: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true,
        },
        username: {
            type: DataTypes.STRING(50),
            allowNull: false,
        },
        email: {
           type: DataTypes.STRING,
           unique: true,
           isEmail: true, //checks for email format
           allowNull: false
       },
        password: {
            type: DataTypes.STRING(100),
            allowNull: false,
        },
        }, {
        tableName: 'User', // Set the table name explicitly to match the PostgreSQL table
        timestamps: false, // Disable timestamps (created_at, updated_at)
    });
    return User;
}