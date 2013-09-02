class MessagesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    id = current_user.id
    @messages = Message.includes(:tutor).where("user_id = ? OR tutor_id = ?", id, id).group('tutor_id')
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
    id = current_user.id
    @message = Message.where("user_id = ? OR tutor_id = ?", id, id).find(params[:id])
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
      params.require(:message).permit(:subject, :body, :tutor_id)
    end
end
