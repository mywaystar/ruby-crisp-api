require 'rest-client'

module Crisp
  class WebsiteOperators
    def initialize(crisp)
      @crisp = crisp
    end

    def get_list(website_id)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "operator"]),
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

    def get_one(website_id, operator_id)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "operator", operator_id]),
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

    def delete_one(website_id, operator_id)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "operator", operator_id]),
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

    def create_one(website_id, params)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "operator"]),
        :method => :post,
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

    def update_one(website_id, operator_id, params)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "operator", operator_id]),
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
