{exec}         = require('child_process')
xml2js         = require('xml2js')
{EventEmitter} = require('events')
crypto         = require('crypto')
_              = require('lodash')

class Scanner extends EventEmitter
  cidr: null
  addresses: {}
  
  constructor: (cidr) ->
    @cidr = cidr
    
  scan: ->
    throw new Error('We need a CIDR to scan!') unless @cidr
    throw new Error('This process must be run as root - nmap requires it to acquire MAC addresses.') unless process.env.SUDO_UID
    
    exec("nmap -oX - -sP #{@cidr}", @processScanStdout)
  
  processScanStdout: (err, stdout) =>
    throw err if err
    
    xml2js.parseString(stdout, @processScanXML)
  
  processScanXML: (err, result) =>
    throw err if err
    
    @addresses = {}
    
    for host in result.nmaprun.host
      mac = ipv4 = null
      for address in host.address
        address = address['$']
        if address.addrtype is 'mac'
          mac = crypto.createHash('sha256').update(address.addr).digest('hex')
        else if address.addrtype is 'ipv4'
          ipv4 = address.addr
      continue unless mac and ipv4
      @addresses[ipv4] = mac
    
    @emit('results')
    
    @scan()
  
  anonymousAddresses: ->
    _.toArray(@addresses)
  
module.exports =
  Scanner: Scanner
