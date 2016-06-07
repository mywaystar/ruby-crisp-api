require 'rest-client'

module Crisp
  class UserAccount
    def initialize(crisp)
      @crisp = crisp
    end

    def get()
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["user", "account"]),
        :method => :get,
        :user => @crisp.auth["identifier"],
        :password => @crisp.auth["key"],
        :headers => {
          :accept => :json,
          :content_type => :json
        }
      )
      serialized = JSON.parse(res);
      return serialized["data"]
    end

    def create(params)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["user", "account"]),
        :method => :post,
        :params => params.to_json,
        :headers => {
          :accept => :json,
          :content_type => :json
        }
      )
      serialized = JSON.parse(res);
      return serialized["data"]
    end
  end
end
