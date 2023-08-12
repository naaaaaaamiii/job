class SearchesController < ApplicationController
  def search 
    @q = Post.ransack(params[:q])
    @post = @q.result(distinct: true)
    @result = params[:q]&.values&.reject(&:blank?)
  end
end
