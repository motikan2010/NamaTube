class CreateVideoTags < ActiveRecord::Migration[5.1]
  def change
    create_table :video_tags do |t|
      t.references :video, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps
    end
  end
end
