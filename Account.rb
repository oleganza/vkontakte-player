module Vkontakte
  class Account
    
    def self.authenticate(email, pass)
      request = Request.new('/login.php')
      response = request.post(:email => email, :pass => pass)
      begin
        parsed_cookie = ::CGI::Cookie.parse(response['Set-Cookie'])
        mid = parsed_cookie['remixmid'].first.to_i
        pass = parsed_cookie['remixpass'].first
        raise "No remixmid!" if mid < 1
        new(mid, email, pass)
      rescue => e
        raise "Can't sign in with #{email}:#{pass}"
      end
    end
    
    attr_accessor :mid, :email, :pass
    def initialize(mid, email, pass)
      @mid = mid
      @email = email
      @pass = pass
    end
    
    # TODO
    # Audio:
    # 
    # operate: function(id, host, user, file, dur)
    # operate(41897582,1107,79609,'c0f4ed0b4e',185):
    # http://cs1107.vkontakte.ru/u79609/audio/c0f4ed0b4e.mp3
    # 
    # "http://cs#{host}.vkontakte.ru/u#{user}/audio/#{file}.mp3"
    # 
    # showLyrics ?
    # 
    # Audio pages:
    # 
    # http://vkontakte.ru/audio.php?act=getpages&id=7146&offset=0
    # http://vkontakte.ru/audio.php?act=getpages&id=7146&offset=50
    # http://vkontakte.ru/audio.php?act=getpages&id=7146&offset=100
    # 
    def playlist
      i = 0
      prev = nil
      current = []
      list = []
      while prev != current
        list += current
        prev = current
        current = get_playlist_with_offset(i)
        puts current.map{|h| h.title}.join("\n")
        i += 50
        sleep 1
      end
      list.uniq
    end
    
    def get_playlist_with_offset(offset)
      body = get("/audio.php", :act => "getpages", :id => @mid, :offset => offset)
      list = parse_audio(body)
    end
    
  private
  
    def get(path, params = {})
      Request.new(path).as(self).get(params).body
    end
    
    def parse_audio(content)
      records = content.scan(/onclick="return operate\((.*?)\);".*?<b id="performer\d+?">(.*?)<\/b>.*?id="title\d+?">(.*?)<\/span>.*?class="duration">(.*?)<\/div>/mi)
      records.map!{|item| {'operate' => item[0], 'performer' => item[1], 'title' => item[2], 'duration' => item[3]}}

      records.map! do |item|
        title_parts = item['title'].scan(/<a.*?showLyrics\((.*?)\);'>(.*?)<\/a>/mi)
        title_parts.size > 0 ? {'lyrics' => title_parts[0][0], 'title' => title_parts[0][1], 'operate' => item['operate'], 'performer' => item['performer'], 'duration' => item['duration']} : item        
      end

      records.map! do |item|
        m, server, user_id, file = item['operate'].split(',')
        file.tr!("'", "")
        title     = item['title']
        lyrics    = item['lyrics']
        performer = item['performer']
        Audio.new(server, user_id, file, title, lyrics, performer)
      end
    end
    
  end
end
