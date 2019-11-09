const path = require('path');
require('dotenv').config({path: path.join(__dirname, './../.env')});

const express = require('express');
const express_graphql = require('express-graphql');
const schema = require('./schema');
const {Client} = require('pg');

const port = process.env.APP_PORT || 5000;
const host = process.env.APP_HOST || '0.0.0.0';
const app = express();

app.use('/', express_graphql({
    schema,
    graphiql: true
}));

global.pg_client = new Client({
    user: process.env.PG_USER,
    host: process.env.PG_HOST,
    database: process.env.PG_DATABASE,
    password: process.env.PG_PASSWORD,
    port: process.env.PG_PORT
});
console.log('Connecting to', process.env.PG_DATABASE, process.env.PG_PORT);
global.pg_client.connect((err) => {
    if (err) {
        console.error('DB Connection error ->', err.stack || err );
    } else {
        app.listen(port, host, () => {
            console.log('GraphQL API server running at', host, port);
        });
    }
});
