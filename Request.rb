module Vkontakte
  class Request
    DOMAIN = 'vkontakte.ru'.freeze
    
    attr_accessor :path, :account, :cookies, :host
    
    def initialize(uri = '/')
      self.host = DOMAIN
      self.path = uri
    end
    
    def as(account)
      self.account = account
      self
    end
    
    def get_personalized(params = {}, person = user)
      with_params :id => person.id do
        get(params)
      end
    end
    
    def get(params = {})
      with_params params do
        handle :get, headers
      end
    end
    
    def post(params)
      handle :post, params.to_params, headers
    end
    
  private
    def connection
      @connection ||= Net::HTTP.start(host)
    end
    
    def handle(method, *args)
      #rescue proxy unavailability thing here
      begin
        args.insert 0, (path[0,1] == "/" ? path : "/#{path}")
        response = connection.send(method, *args)
        response.instance_eval do 
          alias old_body body
          def body 
            @__body ||= Iconv.iconv("UTF-8", "CP1251", old_body).first
          end
        end
        
        if Net::HTTPRedirection === response
          raise "You should log this user in or choose a puppet" if response['Location']["login"]
        end
        response
      rescue Net::HTTPBadResponse => e
        raise "Can't handle the request because of #{e.inspect}"
      end
    end
    
    def headers
      hash = {
        'Content-Type' => 'application/x-www-form-urlencoded',
        'User-Agent' => 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.1) Gecko/20060111 Firefox/1.5.0.1',
        'Referer' => "http://#{DOMAIN}/index.php",
        'Cookie' => @account ? Cookies.new(account).to_s : ''
      }
    end
    
    def with_params(params)
      return yield if params.empty?
      
      old_path = self.path
      self.path += (self.path.index("?") ? "&" : "?") + params.to_params
      yield
    ensure
      self.path = old_path
    end
    
  end
end