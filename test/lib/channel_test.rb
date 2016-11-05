require 'test_helper'
require 'channel'

class SlackChannelTest < ActionController::TestCase
  test "the truth" do
    assert true
  end

  test "must provide a name and an ID for a Slack_Channel" do
    assert_raises ArgumentError do
      Slack_Channel.new(nil, nil)
    end

    assert_raises ArgumentError do
      Slack_Channel.new("", "")
    end

    assert_raises ArgumentError do
      Slack_Channel.new("test", "")
    end

    assert_raises ArgumentError do
      Slack_Channel.new("", "123")
    end

    assert_raises ArgumentError do
      Slack_Channel.new("test", nil)
    end

    assert_raises ArgumentError do
      Slack_Channel.new(nil, "123")
    end
  end

  test "name attribute is set correctly" do
    test_channel = Slack_Channel.new("Test", "1")
    assert_equal "Test", test_channel.name
    # assert test_channel.name == "Test" #Could also use this version
  end

  test "ID attribute is set correctly" do
    test_channel2 = Slack_Channel.new("Test", "1")
    assert_equal "1", test_channel2.id
    # assert test_channel2.id == "1" #Could also use this version
  end

end
