class PostsController < ApplicationController
 before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    post_tags = params[:post][:name].split(',')
    if  @post.save
        @post.save_post_tags(post_tags)
        flash[:notice] = "Success🎉"
        redirect_to users_path
    else
      　flash.now[:alert] = "Error🫠"
        render :new  #保存に失敗したら元のページに戻る
    end
  end

  def index
    @posts = Post.published.page(params[:page]).reverse_order #公開記事のみ表示
  end

   impressionist :actions=> [:show] #showページを開いたらPV数を計測

  def show
     @post = Post.find(params[:id])
     @user = @post.user
     @post_comment = PostComment.new
     @post_tags = @post.post_tag_relationships #タグ表示
     impressionist(@post, nil, unique: [:session_hash]) #pv数計測

  end

  def edit
    @post = Post.find(params[:id])
    @post_tags = @post.post_tags.pluck(:name).join(',')  #タグの編集
  end

  def update
     @post = Post.find(params[:id])
     tag_list = params[:post][:name].split(',')
     if@post.update(post_params)
       @post.save_post_tags(tag_list)
       flash[:notice] = "Success🎉"
       redirect_to post_path(@post)
     else
       flash.now[:alert] = "Error🫠"
      　render :edit
     end
  end

  def destroy #記事の削除
     post = Post.find(params[:id])
     post.destroy
     flash[:notice] = "Success🎉"
     redirect_to users_path
  end



  private

  def post_params
    params.require(:post).permit(:title, :body, :post_status, :post_image)
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to root_path
    end
  end


end
