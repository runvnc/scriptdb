createdb = require './createdb'

express = require 'express'
fs = require 'fs'

delay = (ms, func) -> setTimeout func, ms
interval = (ms, func) -> setInterval func, ms

express = require 'express'
app = express()

app.use express.static('public')

html = fs.readFileSync 'index.html', 'utf8'

app.get '/', (req, res, next) ->
  res.end html

getProducts = (req, res) ->
  if req.query.type is 'undefined'
    db.table('products').run().collect (products) ->
      res.end JSON.stringify(products)
  else
    db.table('products').filter({type: req.query.type}).run().collect (products) ->
      res.end JSON.stringify(products)

app.get '/products', (req, res, next) ->
  getProducts req, res

###
process.on 'uncaughtException', (err) ->
  console.log 'Uncaught exception:'
  console.log err
  console.log err.stack
###

app.listen 3002

createdb.create()

