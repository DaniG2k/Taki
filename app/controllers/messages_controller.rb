class MessagesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @conversation = Conversation.find(params[:conversation_id])
    # This needs to be messages.new
    @message = @conversation.messages.new(message_params)
    
    if @message.save
      redirect_to conversation_path(@conversation)
    # If there are other messages in this thread, don't delete.
    else
      flash[:error] = "Message not sent."
      if empty_thread?(@conversation.id)
        @conversation.delete
        redirect_to conversations_path
      else
        render "conversations/show"
      end
    end
  end
  
  private
    def message_params
      params.require(:message).permit(:subject, :body)
    end
    
    def empty_thread?(convo_id)
      threads = Message.where(conversation_id: convo_id)
      threads.empty?
    end
end