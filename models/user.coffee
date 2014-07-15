redis = require('../redis')

class User
  @all: (callback) ->
    redis.hgetall('users', (err, users) ->
      return callback(err) if err
      callback(null, users or {})
    )
  
  @create: (name, mac, callback) ->
    redis.hset('users', mac, name, callback)

module.exports =
  User: User
