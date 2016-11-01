#require "slack_api_wrapper"
#require "channel"



class HomepagesController < ApplicationController
  def index
    @data = Slack_Api_Wrapper.list_channels
  end

  def create
    # raise
    # Use raise to see params needed for a message in rails server console

    # response = Slack_Api_Wrapper.send_message(params[:channel], params[:message])
    response = Slack_Api_Wrapper.sendmsg(params[:channel], params[:message])

    if response["ok"]
      flash[:notice] = "Post successfully sent to #{params[:channel_name]}."
    else
      flash[:notice] = "Post failed to send to #{params[:channel_name]}."
    end

    redirect_to root_path
  end

  def new
    @channel = params[:name]
    @channel_id = params[:id]
  end
end
