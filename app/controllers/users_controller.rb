class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def index
   @user = current_user
  end

  def show
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to users_path
  end
  
 
  private
   def user_params
    params.require(:user).permit(:name, :introduction, :image)
   end
 
end