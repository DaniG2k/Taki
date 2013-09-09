class UsersController < ApplicationController
  before_filter :authenticate_user!#, except: [:index, :show]
  
  def index
    @users = User.all
  end
  
  #def show
  #  @users = User.all
  #end
end
