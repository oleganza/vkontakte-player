#
#  rb_main.rb
#  VkontaktePlayer
#
#  Created by Oleg Andreev on 04.10.08.
#  Copyright (c) 2008 __MyCompanyName__. All rights reserved.
#

require 'osx/cocoa'

require 'net/http'

require 'iconv'
require 'cgi'
require 'md5'

$KCODE = 'u'

def rb_main_init
  path = OSX::NSBundle.mainBundle.resourcePath.fileSystemRepresentation
  rbfiles = Dir.entries(path).select {|x| /\.rb\z/ =~ x}
  rbfiles -= [ File.basename(__FILE__) ]
  rbfiles.each do |path|
    require( File.basename(path) )
  end
end

if $0 == __FILE__ then
  rb_main_init
  OSX.NSApplicationMain(0, nil)
end
