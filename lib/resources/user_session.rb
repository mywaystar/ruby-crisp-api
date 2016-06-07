require 'rest-client'

module Crisp
  class UserSession
    def initialize(crisp)
      @crisp = crisp
    end

    def login_with_email(email, password)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["user", "session", "login"]),
        :method => :post,
        :payload => {
          :email => email,
          :password => password
        }.to_json,
        :headers => {
          :accept => :json,
          :content_type => :json
        }
      )
      serialized = JSON.parse(res);
      @crisp.auth["identifier"] = serialized["data"]["identifier"];
      @crisp.auth["key"] = serialized["data"]["key"];
      @crisp._prepare_socket
      return serialized["data"]
    end

    def logout()
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["user", "session", "logout"]),
        :method => :post,
        :user => @crisp.auth["identifier"],
        :password => @crisp.auth["key"],
        :headers => {
          :accept => :json,
          :content_type => :json
        }
      )
      serialized = JSON.parse(res);
      @crisp.auth = {}
      return serialized["data"]
    end

    def recover_password(email)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["user", "session", "recover"]),
        :method => :post,
        :payload => {
          :email => email
        }.to_json,
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
