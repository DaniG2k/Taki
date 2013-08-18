class TutorsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_tutor, only: [:index, :update, :edit, :show, :destroy]
  
  def index
    @tutors = Tutor.all
  end
  
  def new
    if current_user.tutor.blank?
      @tutor = current_user.create_tutor #build blank tutor object
    else
      get_tutor
    end
  end
  
  def create
    @tutor = current_user.build_tutor(tutor_params)
    if @tutor.save
      flash[:success] = 'Tutor profile created!'
      redirect_to @tutor
    else
      flash[:error] = 'Tutor profile not created'
      render "new"
    end
  end

  def show
  end
  
  def edit
  end
  
  def update    
    if @tutor.update_attributes(tutor_params)
      flash[:success] = 'Tutor profile updated!'
      redirect_to @tutor
    else
      render "edit"
    end
  end
  
  def destroy
    @tutor.destroy
    redirect_to tutors_path
  end
  
  private
    def tutor_params
      params.require(:tutor).permit(:id, :description, :rate, :country)
    end
    
    def get_tutor
      @tutor = current_user.tutor
    end
end