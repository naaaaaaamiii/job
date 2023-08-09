class PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:name].split(',')
    if  @post.save!
        @post.save_post_tags(tag_list)
        redirect_to posts_path
    else
        render :new　#保存に失敗したら元のページに戻る
    end
  end

  def index
    @posts = Post.all
  end
  
  def show
     @post = Post.find(params[:id])
     @user = @post.user
     @post_comment = PostComment.new
     # タグ表示
     @tag_list = @post.post_tags.pluck(:name).join(',')
     @post_tags = @post.post_tags
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.post_tags.pluck(:name).join(',')
  end
  
  def update
     @tag_list = params[:post][:name].split(',')
  end
  
  def destroy #記事の削除
     post = Post.find(params[:id])
     post.destroy
     redirect_to request.referer
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
