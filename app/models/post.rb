class Post < ApplicationRecord
  belongs_to :user

  enum post_status: { draft:0, published:1 } #下書き,投稿のenumステータス

  has_many :favorites,      dependent: :destroy #いいね機能
  has_many :post_comments,  dependent: :destroy #コメント機能
  has_many :post_tags,      dependent: :destroy #タグ機能
  has_many :tag_genres,     through: :post_tags

  
  def save_tag_genres(tags) #タグ機能
    current_tags = self.tag_genres.pluck(:name) unless self.tag_genres.nil?
    old_tags = current_genres - tags
    new_tags = tags - current_tags
    
    
    old_tags.each do |old_name| #古いタグの削除
      self.tag_genres.delete TagGenre.find_by(name:old_name)
    end
    
     new_tags.each do |new_name| #新しいタグの保存
       tag_genre = TagGenre.find_or_create_by(name:new_name)
       self.tag_genres << tag_genre
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
