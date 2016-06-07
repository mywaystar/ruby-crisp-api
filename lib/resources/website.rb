require 'rest-client'

module Crisp
  class Website
    def initialize(crisp)
      @crisp = crisp
    end

    def create(params)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website"]),
        :method => :post,
        :user => @crisp.auth["identifier"],
        :password => @crisp.auth["key"],
        :params => params.to_json,
        :headers => {
          :accept => :json,
          :content_type => :json
        }
      )
      serialized = JSON.parse(res);
      return serialized["data"]
    end

    def delete(website_id)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id]),
        :method => :delete,
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
