require 'test_helper'
require 'slack_api_wrapper'
require 'channel'

class SlackApiTest < ActionController::TestCase
  test "the truth" do
    assert true
  end

  test "can retrieve a list of channels" do
    VCR.use_cassette("channels") do
      channels = SlackApiWrapper.listchannels

      assert channels.is_a? Array
      assert channels.length > 0

      channels.each do |channel|
        assert channel.is_a? Slack_Channel
      end
    end
  end

  test "retrieves nil when the token is wrong" do
    VCR.use_cassette("bad-token") do
      channels = SlackApiWrapper.listchannels("bad-token")

      assert channels == nil
    end
  end

  test "can send a properly formatted msg" do
    VCR.use_cassette("send-msg") do
      response = SlackApiWrapper.sendmsg("test-api-parens", "This is a test case!")

      assert response["ok"] == true
      assert response["message"]["type"] == "message"
      assert response["message"]["subtype"] == "bot_message"
    end
  end

  test "cannot send a message to a channel that doesn't exist" do
    VCR.use_cassette("nonexistent-channel") do
      response = SlackApiWrapper.sendmsg("channel-doesnt-exist", "Test message")

      assert response["ok"] == false
      assert response["error"] == "channel_not_found"
    end
  end

  test "cannot send a blank message" do
    VCR.use_cassette("nonexistent-msg") do
      response = SlackApiWrapper.sendmsg("test-api-parens", "")

      assert response["ok"] == false
      assert response["error"] == "no_text"
    end
  end

  test "cannot send a message with a bad token" do
    VCR.use_cassette("bad-token") do
      response = SlackApiWrapper.sendmsg("test-api-parens", "Failed message!", "12345")

      assert response["ok"] == false
      assert response["error"] == "invalid_auth"
    end
  end

  test "cannot send a message without a token" do
    VCR.use_cassette("empty-token") do
      response = SlackApiWrapper.sendmsg("test-api-parens", "Failed message!", "")

      assert response["ok"] == false
      assert_equal response["error"], "not_authed"
    end
  end
end
