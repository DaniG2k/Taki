class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end
  
  def new
    # Message requires a user object
    @tutor = Tutor.find(params[:tutor_id])
    
    @message = Message.new
    @message.sender = current_user
    @message.recipient = @tutor.user
    
    if @message.save
      redirect_to tutor_message_path
    else
      render 'new'
    end
  end
end
