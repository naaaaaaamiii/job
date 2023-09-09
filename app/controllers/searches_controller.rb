class SearchesController < ApplicationController
  def search
    @range = params[:range]
    @word = params[:word]
    @model = Post
    @posts = Post.published.where("category LIKE?","%#{@word}%")
    @posts = Post.published.looks(params[:search], params[:word])
  end
end
