class PostTag < ApplicationRecord
  belongs_to :post_tag
  belongs_to :tag_genre
  
  #タグが重複しないようにする
  validates :post_id, presence: true
  validates :tag_id, presence: true
end
