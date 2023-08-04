class Post < ApplicationRecord
  belongs_to :user
  enum post_status: { 下書き:0, 投稿:1 } #下書き,投稿のenumステータス
  
end
