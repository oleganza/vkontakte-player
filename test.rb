require 'rb_main'

require 'Cookies'
require 'Request'
require 'Account'
require 'Audio'

email = "oleganza@gmail.com"
pass = ENV['VKPASSWORD']

alias log puts

account = ::Vkontakte::Account.authenticate(email, pass)
log account.inspect
list = account.playlist
log "Playlist size: #{list.size}"

