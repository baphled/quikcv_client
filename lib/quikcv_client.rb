require 'mash'
require File.join(File.dirname(__FILE__), 'resources', 'my.rb')

module QuikCV

  #
  # Configuration class used to setup a users authentication token
  #
  class Client
    class << self
      
      attr_accessor :token

      def configure
        yield self
        true
      end

      def method_missing api_call
        Mash.new QuikCV::My.get(api_call.to_s.gsub('_','-'), :auth_token => QuikCV::Client.token)
      end
    end
  end
end
