class MessagesController < ApplicationController
  before_action :authenticate_user!
  around_action :catch_not_found
  
  def index
    @messages = Message.all
  end
  
  def new
    # Message requires a user object
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
