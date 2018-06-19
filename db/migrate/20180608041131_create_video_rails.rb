class CreateVideoRails < ActiveRecord::Migration[5.1]
  def change
    create_table :video_rails do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
