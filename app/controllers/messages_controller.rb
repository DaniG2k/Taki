class MessagesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    redirect_to conversation_path(@conversation) if @message.save
  end
  
  private
    def message_params
      params.require(:message).permit(:subject, :body)
    end
end
