class InboxController < ApplicationController
  def index
    @conversations = Conversation.all
  end

  def show
    conversation = Conversation.find(params[:id])
    @messages = conversation.messages
  end
end