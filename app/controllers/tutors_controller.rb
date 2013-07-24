class TutorsController < ApplicationController
  before_filter :authenticate_user!#, except: [:index, :show]
  
  def index
    @tutors = Tutor.all
  end
  
  def new
    @tutor = Tutor.new
  end
  
  def create
    @tutor = Tutor.new(tutor_params)
    
    if @tutor.save
      flash[:notice] = 'The tutor has been created.'
      redirect_to @tutor
    else
      flash[:alert] = 'Tutor has not been created.'
      render :action => 'new'
    end
  end
  
  def show
    @tutor = Tutor.find(params[:id])
  end
  
  def destroy
    @tutor = Tutor.find(params[:id])
    @tutor.destroy
    redirect_to tutors_path
  end
  
  private
    def tutor_params
      params.require(:tutor).permit(:name, :birthday, :description)
    end
end
