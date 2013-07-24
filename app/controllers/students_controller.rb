class StudentsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @students = Student.all
  end
  
  def new
    @student = Student.new
  end
  
  def create
    @student = Student.new(student_params)
    
    if @student.save
      flash[:notice] = 'The student has been created.'
      redirect_to @student
    else
      flash[:alert] = 'Student has not been created.'
      render :action => 'new'
    end
  end
  
  def show
    @student = Student.find(params[:id])
  end
  
  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to students_path
  end
  
  private
    def student_params
      params.require(:student).permit(:name, :birthday, :description)
    end
end
