class Search < ApplicationRecord
   def self.search_all_models(content, model, method)
    if model.present?
      if model == "post"
        Post.search_content(content, method)
      elsif model == "posttag"
        PostTag.search_content(content, method)
      end
    else
      results = []
      results << Post.search_content(content, method)
      results << PostTag.search_content(content, method)
      results.flatten
    end
   end
end
