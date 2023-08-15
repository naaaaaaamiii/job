class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|

      t.integer :admin_id,           null: false
      t.integer :user_id,            null: false
      t.integer :tag_id,             null: false
      t.string  :event_name,         null: false
      t.string  :date,               null: false
      t.text    :event_introduction, null: false
      t.string  :postal_code
      t.string  :adress
      t.text    :url
      t.integer :event_status,       null: false, default:0
      t.integer :status,             null: false, default:0

      t.timestamps
    end
  end
end
