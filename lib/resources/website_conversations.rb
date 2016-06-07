require 'rest-client'

module Crisp
  class WebsiteConversations
    def initialize(crisp)
      @crisp = crisp
    end

    def get_list(website_id, page)
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

    def get_one(website_id, session_id)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "conversation", session_id]),
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

    def fingerprint()
      return Random.new.rand(1..999999999999)
    end

    def send_text_message(website_id, session_id, text)
      @crisp._assert_socket()

      fingerprint = self.fingerprint

      @crisp.socket.emit("message:send", {
        "website_id" => website_id,
        "session_id" => session_id,
        "message" => {
          "type" => "text",
          "origin" => "chat",
          "content" => text,
          "timestamp" =>  DateTime.now.strftime('%Q').to_i,
          "fingerprint" => fingerprint
        }
      })
    end

    def send_text_message(website_id, session_id, text)
      @crisp._assert_socket()

      fingerprint = self.fingerprint

      @crisp.socket.emit("message:send", {
        "website_id" => website_id,
        "session_id" => session_id,
        "message" => {
          "type" => "text",
          "origin" => "chat",
          "content" => text,
          "timestamp" =>  DateTime.now.strftime('%Q').to_i,
          "fingerprint" => fingerprint
        }
      })
    end

    def set_state(website_id, session_id, state)
      @crisp._assert_socket()

      @crisp.socket.emit("session:set_state", {
        "website_id" => website_id,
        "session_id" => session_id,
        "state" => state
      })
    end

    def set_email(website_id, session_id, email)
      @crisp._assert_socket()

      @crisp.socket.emit("session:set_email", {
        "website_id" => website_id,
        "session_id" => session_id,
        "email" => email
      })
    end

    def set_nickname(website_id, session_id, nickname)
      @crisp._assert_socket()

      @crisp.socket.emit("session:set_nickname", {
        "website_id" => website_id,
        "session_id" => session_id,
        "nickname" => nickname
      })
    end

    def set_nickname(website_id, session_id, blocked)
      @crisp._assert_socket()

      @crisp.socket.emit("session:set_block", {
        "website_id" => website_id,
        "session_id" => session_id,
        "blocked" => blocked
      })
    end

    def delete_one(website_id, session_id)
      @crisp._assert_socket()

      @crisp.socket.emit("session:remove", {
        "website_id" => website_id,
        "session_id" => session_id
      })
    end

    def acknowledge_messages(website_id, session_id, fingerprints)
      @crisp._assert_socket()

      @crisp.socket.emit("message:acknowledge:read:send", {
        "website_id" => website_id,
        "session_id" => session_id,
        "fingerprints" => fingerprints
      })
    end
  end
end
