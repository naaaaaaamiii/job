class Post < ApplicationRecord
  belongs_to :user
  enum post_status: { draft:0, published:1 } #下書き,投稿のenumステータス
  
end
