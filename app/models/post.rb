class Post < ApplicationRecord
  belongs_to :user

  enum post_status: { draft:0, published:1 } #下書き,投稿のenumステータス

  has_many :favorites,                   dependent: :destroy #いいね機能
  has_many :post_comments,               dependent: :destroy #コメント機能
  has_many :post_tag_relationships,      dependent: :destroy #タグ機能
  has_many :post_tags,                   through: :post_tag_relationships

  is_impressionable counter_cache: true #PV数計測
 
  def self.looks(search, word) #検索方法
      @post = Post.where("title LIKE?","%#{word}%")
  end
  
  def save_post_tags(tags) #タグ追加する
    current_tags = self.post_tags.pluck(:name) unless self.post_tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    # 古いタグを消す
    old_tags.each do |old_name|
      self.post_tags.delete PostTag.find_by(name:old_name)
    end

    # 新しいタグを保存
    new_tags.each do |new_name|
      post_tag = PostTag.find_or_create_by(name:new_name)
      self.post_tags << post_tag
    end
  end


  def update_post_tags(latest_post_tags) #タグの更新

    if self.post_tags.empty?        #既に登録していたタグが消去されていたら追加のみ行う
        latest_post_tags.each do |latest_post_tag|
          self.post_tags.find_or_sreate_by(name: latest_tag)
        end
    elsif latest_post_tags.empty?  #更新するタグがなかったら既存のタグをすべて消去
      self.post_tags.each do |post_tag|
        self.post_tags.delete(post_tag)
      end
    else
      current_post_tags = self.post_tags.pluck(:name)
      old_post_tags = current_post_tags - latest_post_tags
      new_post_tags = latest_post_tags - current_post_tags

      old_post_tags.each do |old_post_tag|
        post_tag = self.post_tags.find_by(name: old_post_tag)
        self.post_tags.delete(post_tag) if post_tag.present?
      end

      new_post_tags.each do |new_post_tag|
        self.post_tags.find_or_create_by(name: new_post_tag)
      end
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
