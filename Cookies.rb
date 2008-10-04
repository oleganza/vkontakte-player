module Vkontakte
  class Cookies
    PREFIX = 'remix'.freeze
    
    attr_accessor :mid, :email, :pass
    
    def initialize(account)
      return unless account
      @mid      = account.mid 
      @email    = account.email or raise "No Email given"
      @pass     = account.pass  or raise "No pass given"
    end
    
    def pass
      MD5.new @pass
    end
    
    def to_hash
      {
        "#{PREFIX}email" => @email,
        "#{PREFIX}pass"  => @pass,
        "#{PREFIX}mid"   => @mid,
        "#{PREFIX}chk"   => 5,
        "#{PREFIX}lang"  => 3
      }
    end
    
    def to_params
      to_hash.to_params
    end
    
    def to_s
      to_params.gsub('&', '; ')
    end
  end
end

class ::Hash
  def to_params
    params = ''
    stack = []

    each{|k, v| v.is_a?(Hash) ? stack << [k,v] : params << "#{k}=#{v}&"}
    stack.each{|parent, hash| hash.each{|k, v| v.is_a?(Hash) ? stack << ["#{parent}[#{k}]", v] : params << "#{parent}[#{k}]=#{v}&"}}

    params.chop! # trailing &
  end
end
