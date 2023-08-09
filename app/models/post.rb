class Post < ApplicationRecord
  belongs_to :user

  enum post_status: { draft:0, published:1 } #下書き,投稿のenumステータス

  has_many :favorites,                   dependent: :destroy #いいね機能
  has_many :post_comments,               dependent: :destroy #コメント機能
  has_many :post_tag_relationships,      dependent: :destroy #タグ機能
  has_many :post_tags,                   through: :post_tag_relationships

  
  def save_post_tags(tags) #タグ機能
    current_tags = self.post_tags.pluck(:name) unless self.post_tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags
    
    
    old_tags.each do |old_name| #古いタグの削除
      self.post_tags.delete PostTag.find_by(name:old_name)
    end
    
     new_tags.each do |new_name| #新しいタグの保存
       post_tag = PostTag.find_or_create_by(name:new_name)
       self.post_tags << post_tag
     end
  end

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
