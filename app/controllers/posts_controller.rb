class PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    post_tags = params[:post][:tag_id].split(',')
    if  @post.save!
        @post.save_post_tags(post_tags)
        redirect_to posts_path
    else
        render :new　#保存に失敗したら元のページに戻る
    end
  end

  def index
    @posts = Post.all
    #tags = @post.tags.pluck(:name).join(',')
  end
  
  def show
     @post = Post.find(params[:id])
     @user = @post.user
     @post_comment = PostComment.new
     # タグ表示
     @post_tags = @post.post_tags.pluck(:name).join(',')
  end

  def edit
    @post = Post.find(params[:id])
    @post_tags = @post.post_tags.pluck(:name).join(',')
  end
  
  def update
     @post = Post.find(params[:id])
     post_tags = params[:post][:post_tag_id].split(',')
     @post.update(post_params)
     @post.save_post_tags(post_tags)
     redirect_to posts_path
  end
  
  def destroy #記事の削除
     post = Post.find(params[:id])
     post.destroy
     redirect_to request.referer
  end
  
  def search_tag #検索機能(タグのみ)
    @post_tags = PostTag.all
    @post_tag = PostTag.find(params[:tag_genre_id])
    @posts = @post_tag.posts
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :body, :post_status, :post_image)
  end
  
end
