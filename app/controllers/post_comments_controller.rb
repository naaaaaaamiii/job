class PostCommentsController < ApplicationController
 
  def create
   @post = Post.find(params[:post_id])
   comment = PostComment.new(post_comment_params)
   comment.user_id = current_user.id
   comment.post_id = @post.id
   comment.save!
   #redirect_to request.referer 非同期のためコメントアウト
   @post_comment = PostComment.new
  end
  
  def destroy
   @post_comment = PostComment.find(params[:id])
   @post_comment.destroy!
   #redirect_to request.referer　非同期のためコメントアウト
   @post = Post.find(params[:post_id])
  end
  
  def post_comment_params
   params.require(:post_comment).permit(:comment)
  end
  
end
