class ConversationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @conversations = Conversation.all
  end
  
  def new
    recipient = params[:recipient_id]
    sender = current_user.id
    
    @conversation = Conversation.new(sender_id: sender, recipient_id: recipient)# conversation_params)
    @conversation.save
    redirect_to @conversation
  end
  
  def show
    @conversation = Conversation.find(params[:id])
  end
  
  def destroy
    @conversation = Conversation.find(params[:id])
    @conversation.destroy
    redirect_to conversations_path
  end
  
  #private
  #  def conversation_params
  #    params.permit(:recipient_id)
  #  end
end
