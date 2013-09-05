class MessagesController < ApplicationController
  before_action :authenticate_user!
  #around_action :catch_not_found
  
  def index
    id = current_user.id
    @messages = Message.where('sender_id = ? or recipient_id = ?', id, id)
  end
  
  def new
    @tutor = Tutor.find(params[:tutor_id])
    if @tutor.id == current_user.id
      redirect_to tutor_messages_path
    else
      @message = Message.new
    end
  end
  
  def create
    @tutor = Tutor.find(params[:tutor_id])
    @message = Message.new(message_params)
    @message.sender = current_user
    @message.recipient = @tutor.user

    if @message.save
      redirect_to tutor_messages_path
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
      redirect_to tutor_messages_path, :flash => { :error => "Sorry, record not found." }
    end
end
