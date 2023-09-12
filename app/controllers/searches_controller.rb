class SearchesController < ApplicationController
  def search
    @content = params[:content]
    @model = params[:model] || "nil"
    @method = params[:method]
    
    return if @content.blank?
    
    @results = Search.search_all_models(@content, @model, @method)
    
    render "searches/search"
  end
end
