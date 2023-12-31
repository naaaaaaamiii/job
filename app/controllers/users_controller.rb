class UsersController < ApplicationController
 before_action :ensure_guest_user, only: [:edit]
 before_action :is_matching_login_user, only: [:edit, :update]

  def index
   @user = current_user
   @posts = @user.posts.page(params[:page]).reverse_order
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.published.page(params[:page]).reverse_order #公開記事のみ表示する(新しい順)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
     if @user.update(user_params)
       flash[:notice] = "Success🎉"
       redirect_to request.referer
     else
       flash.now[:alert] = "Error🫠"
       render 'edit'
     end
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
    @users = @user.follower_users
  end

  def confirm #下書きした記事のみ表示
    @posts = current_user.posts.draft.page(params[:page]).reverse_order
  end

  private
    
       def user_params
        params.require(:user).permit(:name, :introduction, :image, :post_status)
       end
    
       def ensure_guest_user #ゲストユーザーログイン
          @user = User.find(params[:id])
            if @user.guest_user?
              redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
            end
       end
       
       def is_matching_login_user
         user = User.find(params[:id])
            unless user.id == current_user.id
              redirect_to root_path
            end
       end
  end
