#
#  PlaylistController.rb
#  VkontaktePlayer
#
#  Created by Oleg Andreev on 04.10.08.
#  Copyright (c) 2008 __MyCompanyName__. All rights reserved.
#

require 'osx/cocoa'

class PlaylistController < OSX::NSWindowController
  ib_outlet :emailField
  ib_outlet :passwordField
  ib_outlet :statusField
  
  def awakeFromNib
    clear_log
  end
  
  def update(sender)
    account = ::Vkontakte::Account.authenticate(@emailField.stringValue, @passwordField.stringValue)
    clear_log
    log account.inspect
    list = account.playlist
    log "Playlist size: #{list.size}"
  rescue => e
    log e.inspect
  end
  
  def clear_log
    @statusField.stringValue = ""
  end
  
  def log(msg)
    @statusField.stringValue = @statusField.stringValue + msg + "\n"
  end
  
  ib_action :update
end
