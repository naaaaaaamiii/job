class CreatePostCounts < ActiveRecord::Migration[6.1]
  def change
    create_table :post_counts do |t|
      t.references :user
      t.references :post
      
      t.timestamps
    end
  end
end
