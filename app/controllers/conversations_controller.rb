class ConversationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @conversations = Conversation.all
  end
  
  def new
    sender = current_user.id.to_s
    recipient = params[:recipient_id]
    
    convo_query =  Conversation.where("(sender_id = ? AND recipient_id = ?) OR (recipient_id = ? AND sender_id = ?)",
      sender, recipient, sender, recipient).first
    
    # Prevent current user from messaging himself.
    if recipient == sender
      redirect_to conversations_path
    # Prevent already messaging participants to create
    # more than one conversation.
    elsif convo_query
      @conversation = convo_query
      redirect_to @conversation
    else
      # TODO
      # Add logic for case where there's no subject, no body.
      # In that case, don't save.
      
      # TODO
      # Handle case for when an id is missing. In that case,
      # don't save the message. 
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
