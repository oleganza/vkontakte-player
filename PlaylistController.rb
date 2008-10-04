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
 
  def update(sender)
    @statusField.stringValue = "Email is: " + @emailField.stringValue
  end
  ib_action :update
end
