class PostTag < ApplicationRecord
  
  has_many :post_tag_relationships, dependent: :destroy
  has_many :posts, through: :post_tag_relationships
  
   def self.search_content(content, method)
      if method == "perfect"
        where(name: content).includes(:posts)
      elsif method == "partial"
        where("name LIKE ?", "%#{content}%").includes(:posts)
      else
        all.includes(:posts)
      end
   end
end

