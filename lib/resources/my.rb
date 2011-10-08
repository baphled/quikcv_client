require 'active_resource'
require File.join(File.dirname(__FILE__), '..', 'quikcv_client.rb')

#
# @author Yomi Colledge
#
# Simple wrapper for QuikCV's API calls for a user using authenticated
# tokens
#
# This class allows us to make the expected calls to QuikCV without
# having to deal with all the fluff. 
#
# Please checkout QuikCV's API documentation for more information
#
module QuikCV
  SITE = 'http://api.quikcv.com/api'
  API_VERSION = 'v1'

  class My < ActiveResource::Base
    self.format = :json
    self.site = "#{QuikCV::SITE}/#{QuikCV::API_VERSION}"
    self.collection_name = 'my'
  end
end
