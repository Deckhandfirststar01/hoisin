_     = require('lodash')
redis = require('../redis')

class User
  @all: (callback) ->
    redis.hgetall('users', (err, users) ->
      return callback(err) if err
      
      sortedUsers = []
            
      for mac, name of (users or [])
        sortedUsers.push(mac: mac, name: name)
      
      sortedUsers = _.sortBy(sortedUsers, (u) -> u.name.toLowerCase())
      
      callback(null, sortedUsers)
    )
  
  @create: (name, mac, callback) ->
    redis.hset('users', mac, name, callback)

module.exports =
  User: User
