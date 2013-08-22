class ConversationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @conversations = Conversation.all
  end
  
  def new
    @conversation = Conversation.new(conversation_params)
    if @conversation.save
      redirect_to @conversation
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
  
  private
    def conversation_params
      params.merge!(sender_id: current_user.id.to_s)
      params.permit(:sender_id, :recipient_id)
    end
end
