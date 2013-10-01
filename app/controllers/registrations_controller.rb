class RegistrationsController < Devise::RegistrationsController
  layout "simple", except: [:edit, :update]
  #def edit
  #  super
  #end
end