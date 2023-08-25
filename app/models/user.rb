class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts                              #記事がなくなるとサイトが成り立たないのでユーザーが消えても記事は残す
  has_many :favorites,    dependent: :destroy  #いいね
  has_many :post_comments                      #コメント ユーザーが消えてもコメントは残す
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy #フォローした
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy #フォローされた
  has_many :attendees                          #イベント
  has_many :events,        through: :attendees #イベント
  
  # バリデーション
  validates :name, presence: true
 
 
  #フォロー・フォロワーの一覧を取得
  has_many :following_users, through: :followers, source: :followed
  has_many :follower_users, through: :followeds, source: :follower
 
 
  def follow(user_id) #フォローする時
    followers.create(followed_id: user_id)
  end
 
  def unfollow(user_id) #フォローを外す時
    followers.find_by(followed_id: user_id).destroy
  end
  
  def following?(user) #フォローしてる？
    following_users.include?(user)
  end
 
   def self.looks(search, word) #検索方法
      @user = User.where("title LIKE?","%#{word}%")
   end
 
  has_one_attached :image

  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [width,height]).processed
  end
  
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
  
  # ゲストユーザーログイン
  def guest_user?
    email == GUEST_USER_EMAIL
  end

end
