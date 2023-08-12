class PostTag < ApplicationRecord
  
  has_many :post_tag_relationships, dependent: :destroy
  searchable_attributes %w[name]
end

