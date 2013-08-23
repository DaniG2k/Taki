class ConversationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @conversations = Conversation.all
  end
  
  def new
    sender = current_user.id.to_s
    recipient = params[:recipient_id]
    
    # Prevent current user from messaging himself.
    if recipient == sender
      redirect_to conversations_path
    else
      # Prevent already messaging participants to create
      # more than one conversation.
      query_s = "(sender_id = ? AND recipient_id = ?) OR (recipient_id = ? AND sender_id = ?)"
      convo_query = Conversation.where(query_s, sender, recipient, sender, recipient).first
      if convo_query
        @conversation = convo_query
        redirect_to @conversation
      else
        # TODO
        # Add logic for case where there's (no subject, no body)
        # or an id is missing. In that case, don't save.
        
        @conversation = Conversation.new(conversation_params)
        redirect_to @conversation if @conversation.save
      end
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
