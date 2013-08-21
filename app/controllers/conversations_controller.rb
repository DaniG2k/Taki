class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.all
  end
  
  def new
    recipient = params[:recipient_id]
    sender = current_user.id
    @conversation = Conversation.new(sender_id: sender, recipient_id: recipient)
    if @conversation.save
      redirect_to @conversation
    else
      render 'new'
    end
  end
  
  def show
    @conversation = Conversation.find(params[:id])
  end
  
  def destroy
    @conversation = Conversation.find(params[:id])
    @conversation.destroy
    redirect_to conversations_path
  end
end
