class UsersController < ApplicationController
  def new
    @user = User.new(user_params)
  end
  
  def index
   @user = current_user
   @posts = @user.posts
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.published.page(params[:page]).reverse_order #公開記事のみ表示する
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to request.referer
  end
  
  def favorites #いいね一覧表示のための
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end
  
  def follows #フォローした一覧
    @user = User.find(params[:id])
    @users = @user.following_users
  end
  
  def followers #フォローされた一覧
    @user = User.find(params[:id])
    @user = @user.follower_users
  end
  
  def confirm #下書きした記事のみ表示
    @posts = current_user.posts.draft.page(params[:page]).reverse_order
  end
  
  def myevents
    @user = current_user
    @myevents = @user.events
  end
 
  private
   def user_params
    params.require(:user).permit(:name, :introduction, :image, :post_status)
   end
 
end
