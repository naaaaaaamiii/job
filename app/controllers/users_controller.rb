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
    if params[:event_type] == "created_events"
      @myevents = current_user.events.where(creator_id: current_user.id).page(params[:page]).per(8)
    elsif params[:event_type] == "upcoming_events"
      @myevents = current_user.events.where(creator_id: current_user.id).where("date >= ?", Time.now).page(params[:page]).per(8)
    elsif params[:event_type] == "past_events"
      @myevents = current_user.events.where("date < ?", Time.now).page(params[:page]).per(8)
    elsif params[:event_type] == "attended_events"
      @myevents = Event.joins(:attendees).where(attendees: { user_id: current_user.id }).where.not(creator_id: current_user.id).page(params[:page]).per(8)
    elsif params[:event_type] == "past_attended_events"
      @myevents = Event.joins(:attendees).where(attendees: { user_id: current_user.id }).where("date < ?", Time.now).where.not(creator_id: current_user.id).page(params[:page]).per(8)
    else
      @myevents = Event.joins(:attendees).where(attendees: { user_id: current_user.id }).page(params[:page]).per(8)
    end
    @myevents = current_user.events.where(creator: current_user).page(params[:page]).per(8)
  end
 
  private
   def user_params
    params.require(:user).permit(:name, :introduction, :image, :post_status)
   end
 
end
