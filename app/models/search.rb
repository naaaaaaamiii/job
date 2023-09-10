class Search < ApplicationRecord
    def self.search_all_models(content, model)
    if model.present?
      if model == "post"
        Post.search_content(content)
      elsif model == "event"
        Event.search_content(content)
      elsif model == "posttag"
        Hashtag.search_content(content)
      end
    else
      results = []
      results << Post.search_content(content)
      results << Event.search_content(content)
     # results << Poattag.search_content(content)
      results.flatten
    end
  end
end
