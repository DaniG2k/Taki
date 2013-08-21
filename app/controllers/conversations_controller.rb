class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.all
  end
  
  def new
  end
  
  def create
    #render text: params[:post].inspect
    @conversation = Conversation.new(conversation_params)
    if @conversation.save
      redirect_to @conversation
    else
      render 'new'
    end
  end
  
  def show
    @conversation = Conversation.find(params[:id])
  end
  
  def destroy
    @conversation = Conversation.find(params[:id])
    @conversation.destroy
    redirect_to conversations_path
  end
  
  private
    def conversation_params
      params.require(:post).permit(:id)
    end
end
