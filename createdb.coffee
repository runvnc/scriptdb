#db = require 'rethinkdb-pool'
r = require 'rethinkdb'


#db.setup { db: 'scriptdb' }

opts =
  host: 'localhost'
  port: 28015

cb = (x, y) ->
  console.log 'okdddd'

exports.create = ->
  r.connect opts, (err, cn) ->
    try
      console.log 'trying to create database'
      r.dbCreate('scrisptdb2').run(cn, cb)
    catch e
      console.log 'err'
      console.log e
###
        console.log 'dbcreate ok'
        return null
    catch e
      console.log 'error creating database'
      console.log e
      tryDrop cn, r, done
    return

#tryDrop cn, r, done


db.connect go (cn, r, done) ->
  try
    console.log 'trying to create databse'
    r.dbCreate('scriptdb').run cn, ->
      console.log 'dbcreate ok'
      return null
      tryDrop cn, r, done
  catch e
    console.log 'error creating database'
    console.log e
    tryDrop cn, r, done

tryDrop = (cn, r, done) ->
  db.go (cn, r, done) ->
    try
      r.db('scriptdb').tableDrop('products').run cn, ->
        makeTables cn, r, done
    catch e
      makeTables cn, r, done

makeTables = ->
  db.go (cn, r, done) ->
    try
      r.db('scriptdb').tableCreate('products').run cn, (err) ->
        addData cn, r, done

addData = (cn, r, done) ->
  r.table('products')
    .insert { type: 'outdoor', name: 'Deck Set', price: 189.95 }
  #  .run cn
  #  .insert { type: 'outdoor', name: 'Patio Set', price: 259.95 }
  #  .insert { type: 'electronics', name: 'iPhone 12', price: 899.95 }
  #  .insert { type: 'electronics', name: 'Chromebook', price: 259.95 }
  #  .run cn

###
