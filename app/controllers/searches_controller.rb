class SearchesController < ApplicationController
  def search

    @content = params[:content]
    @model = params[:model] || "nil"

    # 検索ワードが空の場合は何もしない
    return if @content.blank?

    # Array
    @results = Search.search_all_models(@content, @model)

    render "searches/search"
  end
end
