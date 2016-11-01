require 'httparty'

class Slack_Api_Wrapper
  TOKEN = ENV["SLACK_TOKEN"]
  BASE_URL = "https://slack.com/api/"

  def self.list_channels
    url = BASE_URL + "channels.list?token=#{TOKEN}"

    response = HTTParty.get(url)

    my_channels = []

    response["channels"].each do |channel_hash|
      id = channel_hash["id"]
      name = channel_hash["name"]
      my_channels.push(Slack_Channel.new(name, id))
    end

    my_channels
  end

  # def self.send_message(channel, msg)
  #   url = BASE_URL + "chat.postMessage?token=#{TOKEN}" + "&channel=#{channel}" + "&text=#{msg}"
  #
  #   response = HTTParty.get(url)
  # end

  def self.sendmsg(channel, msg, token = nil)
    token = TOKEN if token == nil
    puts "Sending message to channel #{channel}: #{msg}"

    url = BASE_URL + "chat.postMessage?" + "token=#{token}"
    data = HTTParty.post(url,
    body:  {
      "text" => "#{msg}",
      "channel" => "#{channel}",
      "username" => "cat",
      "icon_emoji" => ":heart_eyes_cat:",
      "as_user" => "false"
    },
    :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' })
  end

end
