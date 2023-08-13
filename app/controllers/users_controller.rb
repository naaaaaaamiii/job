class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def index
   @user = current_user
   @posts = @user.posts
  end

  def show
    @posts = Post.all
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to users_path
  end
  
  def favorites #いいね一覧表示のための
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
    @post = Post.find(params[:id])
  end
  
  def follows #フォローした一覧
    user = User.find(params[:id])
    @users = user.following_users
  end
  
  def followers #フォローされた一覧
    user = User.find(params[:id])
    @user = user.follower_users
  end
 
  private
   def user_params
    params.require(:user).permit(:name, :introduction, :image)
   end
 
end
