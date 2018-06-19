class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.integer :user_id
      t.integer :video_rail_id
      t.string :youtube_id
      t.text :title
      t.string :thumbnail
      t.integer :source_type

      t.timestamps
    end
  end
end
