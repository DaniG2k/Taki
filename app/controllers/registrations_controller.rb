class RegistrationsController < Devise::RegistrationsController
  #before_action :check_tutor_is_built, only: :edit
  
  #def edit
  #  super
  #end
  
  #private
  #  def check_tutor_is_built
  #    resource.build_tutor unless resource.tutor
  #  end
end