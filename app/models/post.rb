class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :post_image #投稿の画像表示
  enum post_status: { draft:0, published:1 } #下書き,投稿のenumステータス
  
end
