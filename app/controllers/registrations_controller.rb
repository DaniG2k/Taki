class RegistrationsController < Devise::RegistrationsController
  before_filter :check_tutor_is_built, only: :edit
  
  def edit
    super
  end
  
  private
    def check_tutor_is_built
      current_user.build_tutor unless current_user.tutor
    end
end