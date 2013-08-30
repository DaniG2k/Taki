class ConversationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    # Clean out empty message conversations.
    Conversation.find_each {|c| c.destroy if c.messages.empty?}
    #binding.pry
    #@conversations = Conversation.all
    @conversations = user_conversations
  end
  
  def new
    sender = current_user.id.to_s
    recipient = params[:recipient_id] 
    # Prevent current user from messaging himself.
    # Prevent accessing /new if no recipient provided.
    if(recipient == sender or recipient.nil?)
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
        @conversation = Conversation.new(conversation_params)
        redirect_to @conversation if @conversation.save
      end
    end
  end
  
  def show
    @conversation = user_conversations.find(params[:id])
  end
  
  def destroy
    @conversation = user_conversations.find(params[:id])
    @conversation.destroy
    redirect_to conversations_path
  end
  
  private
    def conversation_params
      params.merge!(sender_id: current_user.id.to_s)
      params.permit(:sender_id, :recipient_id)
    end
    
    def user_conversations
      usrid = current_user.id.to_s
      Conversation.where("sender_id = ? OR recipient_id = ?", usrid, usrid)
    end
end