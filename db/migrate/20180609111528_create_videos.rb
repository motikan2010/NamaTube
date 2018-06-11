class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.integer :user_id
      t.string :url
      t.text :title
      t.string :thumbnail
      t.integer :source_type

      t.timestamps
    end
  end
end
