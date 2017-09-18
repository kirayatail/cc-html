var express = require('express');
var app = express();
var http = require('http');
var websocket = require('websocket').server;

app.get('/', (req,res) => {
    console.log('Requested /');
    return res.sendFile('index.html', {root: __dirname});
});

app.use(express.static('dist'));

app.listen(3000, () => {
  console.log('Listening to port 3000');
})
