class SearchesController < ApplicationController
  def search
    @range = params[:range]
    @word = params[:word]
    if @range == "tag"
      @tags = PostTag.where(params[:search], params[:word])
    else
      @posts = Post.published.looks(params[:search], params[:word])
    end
  end
end
