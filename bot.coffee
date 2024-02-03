discordie = require 'discordie'
config = require './config'

client = new discordie(autoReconnect: yes)

client.connect token: config.token

client.Dispatcher.on "GATEWAY_READY", (e) ->
  user = client.User
  if user?
    a = user.getApplication()
    console.log "[INFO] Connected as #{user.username}"
  else
    console.log "[ERROR] Client does not have associated user information."

client.Dispatcher.on "DISCONNECTED", (e) ->
  if e.error is "Login failed"
    console.log "[INFO] Failed to connect! Retrying..."
  else
    console.log "[INFO] Disconnected! Trying to reconnect..."

client.Dispatcher.on "GATEWAY_RESUMED", (e) ->
  console.log "[INFO] Reconnected!"
