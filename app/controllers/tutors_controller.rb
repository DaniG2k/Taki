class TutorsController < ApplicationController
  before_filter :authenticate_user!
  
  def edit
  end
  
  def show
  end
  
  def update
    if @tutor.update_attributes(tutor_params)
      flash[:success] = 'Tutor profile updated'
      redirect_to @tutor
    else
      flash[:error] = 'Tutor profile not updated'
      render 'edit'
    end
  end
  
  private
    def tutor_params
      params.require(:tutor).permit(:id, :description, :rate, :country)
    end
end