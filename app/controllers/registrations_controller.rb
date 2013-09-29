class RegistrationsController < Devise::RegistrationsController
  layout "simple", except: [:edit]  
  #def edit
  #  super
  #end
end