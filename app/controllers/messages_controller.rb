class MessagesController < ApplicationController
  before_action :authenticate_user!
  around_action :catch_not_found
  
  def index
    @messages = fetch_user_messages.includes(:tutor).group('tutor_id')
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
    @message = fetch_user_messages.find(params[:id])
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
    
    def fetch_user_messages
      id = current_user.id
      Message.where("user_id = ? OR tutor_id = ?", id, id)
    end
    
    def catch_not_found
      yield
    rescue ActiveRecord::RecordNotFound
      redirect_to tutor_messages_path, :flash => { :error => "Record not found." }
    end
end
