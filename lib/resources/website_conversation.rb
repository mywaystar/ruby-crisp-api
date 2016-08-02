require 'rest-client'

module Crisp
  class WebsiteConversation
    def initialize(crisp)
      @crisp = crisp
    end

    def create_new_conversation(website_id)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "conversation"]),
        :method => :post,
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

    def check_conversation_exists(website_id, session_id)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "conversation", session_id]),
        :method => :head,
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

    def get_conversation(website_id, session_id)
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

    def remove_conversation(website_id, session_id)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "conversation", session_id]),
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

    def initiate_conversation_with_existing_session(website_id, session_id)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "conversation", session_id, "initiate"]),
        :method => :post,
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

    def get_messages_in_conversation(website_id, session_id)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "conversation", session_id, "messages"]),
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

    def send_message_in_conversation(website_id, session_id, message)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "conversation", session_id, "message"]),
        :method => :post,
        :user => @crisp.auth["identifier"],
        :password => @crisp.auth["key"],
        :payload => message.to_json,
        :headers => {
          :accept => :json,
          :content_type => :json
        }
      )
      serialized = JSON.parse(res);
      return serialized
    end


    def compose_message_in_conversation(website_id, session_id, compose)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "conversation", session_id, "compose"]),
        :method => :patch,
        :user => @crisp.auth["identifier"],
        :password => @crisp.auth["key"],
        :payload => compose.to_json,
        :headers => {
          :accept => :json,
          :content_type => :json
        }
      )
      serialized = JSON.parse(res);
      return serialized["data"]
    end

    def mark_messages_read_in_conversation(website_id, session_id, read)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "conversation", session_id, "read"]),
        :method => :patch,
        :user => @crisp.auth["identifier"],
        :password => @crisp.auth["key"],
        :payload => read.to_json,
        :headers => {
          :accept => :json,
          :content_type => :json
        }
      )
      serialized = JSON.parse(res);
      return serialized["data"]
    end

    def get_conversation_metas(website_id, session_id)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "conversation", session_id, "meta"]),
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

    def update_conversation_metas(website_id, session_id, metas)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "conversation", session_id, "meta"]),
        :method => :patch,
        :user => @crisp.auth["identifier"],
        :password => @crisp.auth["key"],
        :payload => metas.to_json,
        :headers => {
          :accept => :json,
          :content_type => :json
        }
      )
      serialized = JSON.parse(res);
      return serialized["data"]
    end

    def get_conversation_state(website_id, session_id, metas)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "conversation", session_id, "state"]),
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

    def change_conversation_state(website_id, session_id, state)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "conversation", session_id, "state"]),
        :method => :patch,
        :user => @crisp.auth["identifier"],
        :password => @crisp.auth["key"],
        :payload => {
          :state => state
        }.to_json,
        :headers => {
          :accept => :json,
          :content_type => :json
        }
      )
      serialized = JSON.parse(res);
      return serialized["data"]
    end

    def get_block_status_for_conversation(website_id, session_id, blocked)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "conversation", session_id, "block"]),
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

    def block_incoming_messages_for_conversation(website_id, session_id, blocked)
      res = RestClient::Request.execute(
        :url => @crisp._prepare_rest_url(["website", website_id, "conversation", session_id, "block"]),
        :method => :patch,
        :user => @crisp.auth["identifier"],
        :password => @crisp.auth["key"],
        :payload => {
          :blocked => blocked
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
