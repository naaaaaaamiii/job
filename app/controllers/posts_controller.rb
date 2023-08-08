class PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:name].split(',')
    @post.save!
    @post.save_tags(tag_list)
    redirect_to posts_path
  end

  def index
    @posts = Post.all
    # タグ表示
    @post = Post.find(params[:id])
    @tag_list = @post.tag_genres.pluck(:name).join(',')
    @post_tags = @post.tag_genres
  end
  
  def show
     @post = Post.find(params[:id])
     @user = @post.user
     @post_comment = PostComment.new
  end

  def edit
    @tag_list = @post_workout.workout_tags.pluck(:name).join(',')
  end
  
  def update
     @tag_list = params[:post][:name].split(',')
  end
  
  def search_tag #検索機能(タグのみ)
    @tag_list = PostTag.all
    @tag = PostTag.find(params[:tag_genre_id])
    @posts = @tag.posts
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :body, :post_status, :post_image)
  end
  
end
