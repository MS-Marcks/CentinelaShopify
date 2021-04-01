'use strict';
if (process.env.NODE_ENV !== 'production') {
    require("dotenv").config()   
}
const Connect = {
    host: process.env.DB_HOST ,
    user:  process.env.DB_USER, 
    password: process.env.DB_PASSWORD,
    database:  process.env.DB_DATABASE
}

export default Connect;