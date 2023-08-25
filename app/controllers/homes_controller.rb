class HomesController < ApplicationController
  def top
    #新着投稿順に表示する
    @posts = Post.latest.limit(6)
    # いいねが多い順に表示する
    @favorites = Post.find(Favorite.group(:post_id).order('count(post_id) DESC').limit(6).pluck(:post_id))
    # 閲覧数が多い順
    @impressions = Post.impressions_count.limit(6)
    
    @events = Event.all
    
  end

end
