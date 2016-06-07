require 'rest-client'

module Crisp
  class WebsiteSettings
    def initialize(crisp)
      @crisp = crisp
    end

    def get(website_id)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "settings"]),
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

    def update(website_id, params)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "settings"]),
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
