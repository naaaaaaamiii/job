class Event < ApplicationRecord
  has_many :attendees
  belongs_to :creator, class_name: "User"
  has_many :users, through: :attendees

  scope :latest, -> {order(created_at: :desc)} #新しい順に並べる
  
  enum event_status: { offline: 0, online: 1 } #イベント開催オフラインかオンラインか
  
  
  
  # バリデーション
  validates :event_name, :date, :event_introduction, presence: true

  def includesUSesr?(user) #ユーザーがイベントの参加者かどうか
    attendees.exists?(attendee_id: user_id)
  end
  

  validate :date
   def date_check #dateが今日より前の日付は設定できないようにする。
     unless date == nill
       errors.add(:date,"は今日以降の日付を入力してください")if date < Date.tody
     end
   end

  has_one_attached :event_image

  def get_event_image(width,height)
    unless event_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      event_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      event_image.variant(resize_to_limit: [width,height]).processed
  end
end
