class TagGenre < ApplicationRecord
   has_many :post_tags, dependent: :destroy
   has_many :tag_genres, through: :post_tags
   
   validates :name, presence:true, length:{maximum:50}
end
