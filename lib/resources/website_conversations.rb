require 'rest-client'

module Crisp
  class WebsiteConversations
    def initialize(crisp)
      @crisp = crisp
    end

    def list(website_id, page = 0)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "conversations", page]),
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

    def search(website_id, page = 0, search_type, search_query)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url([
          "website",
          website_id,
          "conversations",
          page,
          "?search_type =" + search_type + "&search_query=" + search_query]
        ),
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
  end
end
