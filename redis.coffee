redis = require('redis').createClient()
redis.select(1)

module.exports = redis
