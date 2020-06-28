let http = require('http')
let fs = require('fs')
let url = require('url')
let server = http.createServer()

/*
v12.17.0
const EventEmitter = require('events')

let nodejsApp = {
    start : function(port){
        let emitter = new EventEmitter()
        let server = http.createServer((request,response) => { 
            if (request.url === '/') {
                emitter.emit('root', response)
            }
            response.end()
        }).listen(port)
        return emitter
    }
}

let app = nodejsApp.start(8080)

app.on('root', function (response) {
    
    fs.readFile('file.html', 'utf8', (data) => {
        response.writeHead(200,{'Content-Type' : 'text/html; charset=utf-8'})
        response.write(data)
    })

})
*/

server.on('request', (request,response) => {
    response.writeHead(404,{'Content-Type': 'text/html; charset=utf-8'})
    let query = url.parse(request.url, true).query
    let name = query.name === undefined ? 'anonyme' : query.name

    fs.readFile('file.html', 'utf8', (err, data) => {
        if (err) {
            response.writeHead(404,{'Content-Type' : 'text/html; charset=utf-8'})
            response.write("Mauvais fichier spécifié")
        } else {
            response.writeHead(200,{'Content-Type' : 'text/html; charset=utf-8'})
            data = data.replace('{{ name }}', query.name)
            response.write(data)
        }
        response.end()
    })
})
server.listen('8080')

