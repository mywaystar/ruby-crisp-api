require 'crisp'

crisp_client = Crisp::Client.new

crisp_client.user_session.login_with_email("testUser@gmail.com", "testtest")

profile = crisp_client.user_profile.get()
puts "Hello " + profile["first_name"]

crisp_client.on "message:send" do |message|
  crisp_client.website_conversations.send_message_in_conversation(
    message["website_id"],
    message["session_id"],
    {
      :origin  => "chat",
      :content => "I'm a bot",
      :type    => "text",
      :from    => "operator"
    }
  )
end

#trick to keep the script running
loop do
  msg = STDIN.gets.strip
end
