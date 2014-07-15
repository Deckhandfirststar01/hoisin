socket = io()
socket.on 'results', (data) ->
  users = document.querySelectorAll('.user')
  
  for user in users
    mac = user.getAttribute('data-mac')
    state = if data.indexOf(mac) isnt -1 then 'in' else 'out'
    user.querySelector('.status').className = "status #{state}"
