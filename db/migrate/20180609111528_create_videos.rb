class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.integer :user_id
      t.integer :video_rail_id
      t.integer :sort
      t.string :youtube_id
      t.text :title
      t.string :thumbnail
      t.integer :play_time

      t.timestamps
    end
  end
end
