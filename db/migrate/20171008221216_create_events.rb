class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :image_url
      t.datetime :beg_time
      t.datetime :end_time
      t.integer :max_athletes
      t.string :location
      t.integer :user_id
      t.integer :sport_id

      t.timestamps
    end
  end
end
