class UsersController < ApplicationController
  before_filter :authenticate_user!#, except: [:index, :show]
  
  def show
    @users = User.all
  end
  
end
