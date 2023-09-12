class PostTag < ApplicationRecord
  
  has_many :post_tag_relationships, dependent: :destroy
  
   def self.search_content(content, method)
      if method == "perfect"
        where(name: content)
      elsif method == "partial"
        where("name LIKE ?", "%#{content}%")
      else
        all
      end
   end
end

