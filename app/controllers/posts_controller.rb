class PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:name].split(',')
    @post.save!
    @post.save_tag_genres(tag_list)
    redirect_to posts_path
  end

  def index
    @posts = Post.all
  end
  
  def show
     @post = Post.find(params[:id])
     @user = @post.user
     @post_comment = PostComment.new
  end

  def edit
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :body, :post_status, :post_image)
  end
  
end
