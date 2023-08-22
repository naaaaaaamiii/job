class HomesController < ApplicationController
  def top
    @posts = Post.all
    @favorites = Post.find(Favorite.group(:post_id).order('count(post_id) DESC').limit(6).pluck(:post_id))
  end

end
