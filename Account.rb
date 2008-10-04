module Vkontakte
  class Account
    
    def self.authenticate(email, pass)
      request = Request.new('/login.php')
      response = request.post(:email => email, :pass => pass)
      begin
        mid = ::CGI::Cookie.parse(response['Set-Cookie'])['remixmid'].first.to_i
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
    def playlist
      []
    end
        
  end
end
