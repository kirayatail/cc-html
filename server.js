var app = require('express')();
var http = require('http');
var websocket = require('websocket').server;

app.get('/', (req,res) => {
    console.log('Requested /kkk')
    return res.sendFile('index.html');
});

var server = http.createServer(app);

server.listen(6000);
