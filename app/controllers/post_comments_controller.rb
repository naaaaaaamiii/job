class PostCommentsController < ApplicationController
 
  def create
   @post = Post.find(params[:post_id])
   @post_comment = PostComment.new(post_comment_params)
   @post_comment.user_id = current_user.id
   @post_comment.post_id = @post.id
   @post_comment.save!
  # redirect_to request.referer #非同期のためコメントアウト
  end
  
  def destroy
   @post_comment = PostComment.find(params[:id])
   @post_comment.destroy!
   #redirect_to request.referer 非同期のためコメントアウト
   @post = Post.find(params[:post_id])
  end
  
  def post_comment_params
   params.require(:post_comment).permit(:comment, :post_id)
  end
  
end
