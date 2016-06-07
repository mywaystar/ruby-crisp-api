require 'rest-client'

module Crisp
  class UserSchedule
    def initialize(crisp)
      @crisp = crisp
    end

    def get()
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["user", "account", "schedule"]),
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

    def update(params)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["user", "account", "schedule"]),
        :method => :patch,
        :params => params.to_json,
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
  end
end
