require 'rubygems'
Gem.path.unshift(File.join(File.expand_path(File.dirname(__FILE__))))
require 'htmlentities'

module Vkontakte
  class Audio
    attr_accessor :server, :user_id, :file
    attr_accessor :title, :lyrics, :artist
    
    @@html_coder = HTMLEntities.new
    
    def self.new(s, u, f, *args)
      @cache ||= {}
      key = "#{s}:#{u}:#{f}"
      @cache[key] ||= super(s, u, f, *args)
    end
    
    def file_name(folder = nil)
      n = "#{@artist} - #{@title}.mp3".gsub(%{"}, '')
      return n unless folder 
      File.join(folder, n)
    end
    
    def stamp
      "#{@server}-#{@user_id}-#{@file}"
    end
    
    def initialize(server, user_id, file, title, lyrics, artist)
      @server = server
      @user_id = user_id
      @file = file
      @title = decode(title)
      @lyrics = decode(lyrics)
      @artist = decode(artist)
    end
    
    def url
      %{http://cs#{@server}.vkontakte.ru/u#{@user_id}/audio/#{@file}.mp3}
    end
    
    def decode(t)
      @@html_coder.decode(t)
    end
  end
end
