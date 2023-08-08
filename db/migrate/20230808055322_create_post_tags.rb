class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      
      t.references :post,      foreign_key: true, null:false
      t.references :tag_genre, foreign_key: true, null:false
      
      t.timestamps
    end
  end
end
