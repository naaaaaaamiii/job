class FavoritesController < ApplicationController
 def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
    #redirect_to post_path(post)
    
 end
  
  def destroy
    podt = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: podt.id)
    favorite.destroy
    #redirect_to post_path(post)
  end
end
