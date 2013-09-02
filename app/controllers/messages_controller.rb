class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_user_messages, only: [:show]
  
  def index
    id = current_user.id
    @messages = Message.includes(:tutor).where("user_id = ? OR recipient_id = ?", id, id).group('recipient_id')
  end
  
  def new
    @tutor = Tutor.find(params[:tutor_id])
    if @tutor.id == current_user.id
      redirect_to tutor_messages_path 
    else
      @message = @tutor.messages.build
    end
  end
  
  def show
    @message = @messages.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to tutor_messages_path
  end
  
  def create
    @tutor = Tutor.find(params[:tutor_id])
    @message = @tutor.messages.build(message_params)
    @message.user_id = current_user.id

    if @message.save
      redirect_to tutor_message_path @tutor, @message
    else
      render 'new'
    end
  end
  
  private
    def message_params
      params.require(:message).permit(:subject, :body, :recipient_id)
    end
    
    def fetch_user_messages
      id = current_user.id
      @messages = Message.where("user_id = ? OR recipient_id = ?", id, id)
    end
end
