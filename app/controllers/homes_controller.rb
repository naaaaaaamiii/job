class HomesController < ApplicationController
  def top
    @posts = Post.all
    # いいねが多い順に表示する
    @favorites = Post.find(Favorite.group(:post_id).order('count(post_id) DESC').limit(6).pluck(:post_id))
    # 閲覧数が多い順
    @views = Post.find()
  end

end
