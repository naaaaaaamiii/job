class Event < ApplicationRecord
  has_many :user, through: :atten
  has_many :attendees
  belongs_to :creator, class_name: "User"
  
  
  enum event_status: { offline: 0, online: 1 } #イベント開催オフラインかオンラインか
  
  def includesUSesr?(user) #ユーザーがイベントの参加者かどうか
    attendees.exists?(attendee_id: user_id)
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
