class Post < ApplicationRecord
  belongs_to :user
  
  enum post_status: { draft:0, published:1 } #下書き,投稿のenumステータス
  
  has_many :favorites, dependent: :destroy #いいね機能
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  has_one_attached :post_image #投稿の画像表示
  
  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      post_image.variant(resize_to_limit: [width, height]).processed
  end
end
