let app = require('express')()

app.get('/', (request,response) => {
    response.send("Hello")
})

app.listen(8080)