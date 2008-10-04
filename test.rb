require 'rb_main'

require 'Cookies'
require 'Request'
require 'Account'
require 'Audio'
require 'Playlist'

email = "oleganza@gmail.com"
pass = ENV['VKPASSWORD']

alias log puts

if false
  pl = Vkontakte::Playlist.new([])
  pl.update_itunes
  exit
end

account = ::Vkontakte::Account.authenticate(email, pass)
log account.inspect
list = account.playlist
list.each do |item|
  puts item.file_name
end

p list.folder

p list.update_files

log "Playlist size: #{list.size}"

