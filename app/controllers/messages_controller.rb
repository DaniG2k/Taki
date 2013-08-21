class MessagesController < ApplicationController
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.create(message_params)
    redirect_to conversation_path(@conversation)
  end
  
  private
    def message_params
      params.require(:message).permit(:subject, :body)
    end
end
