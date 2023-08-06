class FavoritesController < ApplicationController
 def create
    podt = Post.find(params[:post_id])
    favorites = current_user.favorites.new(post_id: post.id)
    favorite.save
    redirect_to posts_path
    
 end
  
  def destroy
    podt = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(podt_id: podt.id)
    favorite.destroy
    redirect_to posts_path
  end
end
