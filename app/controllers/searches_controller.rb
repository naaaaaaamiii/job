class SearchesController < ApplicationController
  def search
    @content = params[:content]
    @model = params[:model] || "nil"
    @method = params[:method]
    
    return if @content.blank?
    
    if @model == "posttag"
      @posts = Post.joins(:post_tags).where(post_tags: { posttag_name: @content }).order(created_at: :desc).page(params[:page]).per(8)
    end
    
    @results = Search.search_all_models(@content, @model, @method)
    
    render "searches/search"
  end
end
