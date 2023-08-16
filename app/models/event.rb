class Event < ApplicationRecord
  has_many :user, through: :attendees
  has_many :attendees
  
  
  enum event_status: { offline: 0, online: 1 } #イベント開催オフラインかオンラインか
  
  has_one_attached :event_image
  
  def get_event_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      event_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      event_image.variant(resize_to_limit: [width,height]).processed
  end
end
