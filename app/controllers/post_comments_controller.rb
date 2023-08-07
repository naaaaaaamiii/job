class PostCommentsController < ApplicationController
 
  def create
   post = Post.find(params[:post_id])
   comment = PostComment.new(post_comment_params)
   comment.user_id = current_user.id
   comment.post_id = post.id
   comment.save
   redirect_to request.referer
  end
  
  def destroy
   @comment = PostComment.find(params[:id])
   @comment.destroy
  end
  
  def post_comment_params
   params.require(:post_comment).permit(:comment)
  end
  
end
