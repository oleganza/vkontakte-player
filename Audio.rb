module Vkontakte
  class Audio
    attr_accessor :server, :user_id, :file
    attr_accessor :title, :lyrics, :performer
    
    def self.new(s, u, f, *args)
      @cache ||= {}
      key = "#{s}:#{u}:#{f}"
      @cache[key] ||= super(s, u, f, *args)
    end
    
    def initialize(server, user_id, file, title, lyrics, performer)
      @server = server
      @user_id = user_id
      @file = file
      @title = title
      @lyrics = lyrics
      @performer = performer
    end
    
    def file_url
      "http://cs#{@server}.vkontakte.ru/u#{@user_id}/audio/#{@file}.mp3"
    end
  end
end
