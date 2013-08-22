class ConversationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @conversations = Conversation.all
  end
  
  def new
    sender = current_user.id
    recipient = params[:recipient_id].to_i
    convo_by_sender_found = Conversation.find_by_sender_id(sender)
    convo_by_recipient_found = Conversation.find_by_recipient_id(sender)
    
    # Prevent current user from messaging himself.
    if recipient == sender
      redirect_to conversations_path
    
    # Prevent already messaging participants to create
    # more than one conversation.
    elsif convo_by_sender_found
      @conversation = convo_by_sender_found
      redirect_to @conversation
    elsif convo_by_recipient_found
      @conversation = convo_by_recipient_found
      redirect_to @conversation
    else
      @conversation = Conversation.new(conversation_params)
      redirect_to @conversation if @conversation.save
    end
  end
  
  def show
    # Prevent seeing/destroying other's messages.
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
