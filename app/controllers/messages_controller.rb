class MessagesController < ApplicationController
  before_action :authenticate_user!
  around_action :catch_not_found
  
  def index
    id = current_user.id
    @messages = Message.where('sender_id = ? or recipient_id = ?', id, id)
  end
  
  def new
    @tutor = Tutor.find(params[:recipient_id]).user
    
    if @tutor.id == current_user.id
      redirect_to tutors_path
    else
      @message = Message.new
    end
  end
  
  def create
    @tutor = Tutor.find(params[:recipient_id]).user
    @message = Message.new(message_params)
    @message.sender = current_user
    @message.recipient = @tutor

    if @message.save
      redirect_to messages_path
    else
      render 'new'
    end
  end
  
  private
    def message_params
      params.require(:message).permit(:subject, :body)
    end
    
    def catch_not_found
      yield
    rescue ActiveRecord::RecordNotFound
      redirect_to tutors_path, flash: { :notice => "Sorry, that recipient was not found :(" }
    end
end
