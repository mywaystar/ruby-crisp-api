require 'rubygems'
require 'event_emitter'
require 'rest-client'
require 'socket.io-client-simple'
require 'resources/user_session'
require 'resources/user_account'
require 'resources/user_notification'
require 'resources/user_schedule'
require 'resources/user_profile'
require 'resources/user_websites'
require 'resources/website'
require 'resources/website_operators'
require 'resources/website_settings'
require 'resources/website_statistics'
require 'resources/website_conversations'
require 'resources/website_conversation'

module Crisp
  class Client
    attr_writer :rest_host
    attr_writer :rest_base_path
    attr_writer :realtime_host

    attr_accessor :user_session
    attr_accessor :user_account
    attr_accessor :user_notification
    attr_accessor :user_schedule
    attr_accessor :user_profile
    attr_accessor :user_websites
    attr_accessor :website
    attr_accessor :website_operators
    attr_accessor :website_settings
    attr_accessor :website_statistics
    attr_accessor :website_conversations
    attr_accessor :website_conversation
    attr_accessor :auth
    attr_accessor :socket

    include EventEmitter

    def initialize()
      @auth = {  }
      @user_session           = Crisp::UserSession.new(self)
      @user_account           = Crisp::UserAccount.new(self)
      @user_notification      = Crisp::UserNotification.new(self)
      @user_schedule          = Crisp::UserSchedule.new(self)
      @user_profile           = Crisp::UserProfile.new(self)
      @user_websites          = Crisp::UserWebsites.new(self)
      @website                = Crisp::Website.new(self)
      @website_operators      = Crisp::WebsiteOperators.new(self)
      @website_settings       = Crisp::WebsiteSettings.new(self)
      @website_statistics     = Crisp::WebsiteStatistics.new(self)
      @website_conversations  = Crisp::WebsiteConversations.new(self)
      @website_conversation   = Crisp::WebsiteConversation.new(self)
    end

    def rest_host
      @rest_host || "https://api.crisp.im"
    end

    def rest_base_path
      @rest_host || "/v1/"
    end

    def realtime_host
      @realtime_host || "https://relay-app.crisp.im:443"
    end

    def _prepare_rest_url(paths)
      return self.rest_host + self.rest_base_path + paths.join("/")
    end

    def _prepare_socket()
      @socket = SocketIO::Client::Simple.connect self.realtime_host
      self._authenticate()
      self._bind_all_events()
    end

    def _authenticate()
      sleep 0.3
      @socket.emit("authentication", {
        "username" => @auth["identifier"],
        "password" => @auth["key"],
      })
    end

    def _assert_socket()
      if @socket == nil
        raise "You are not logged"
      end
    end

    def _bind_all_events()
      this = self

      ["message:send",
      "message:received",
      "message:compose:send",
      "message:acknowledge:read:send",
      "message:acknowledge:read:received",
      "message:acknowledge:delivered",
      "session:update_availability",
      "session:request:initiatedy",
      "session:set_email",
      "session:set_nickname",
      "session:set_avatar",
      "session:set_cover",
      "session:set_block",
      "session:set_state",
      "session:set_tags",
      "session:sync:pages",
      "session:sync:geolocation",
      "session:sync:system",
      "session:sync:extended_informations",
      "session:sync:removed"].each do |event_name|
        self._bind_one(event_name)
      end
    end

    def _bind_one(event_name)
      this = self
      @socket.on event_name do |data|
        this.emit(event_name, data)
      end
    end

  end
end
