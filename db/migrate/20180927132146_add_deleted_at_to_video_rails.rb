class AddDeletedAtToVideoRails < ActiveRecord::Migration[5.1]
  def change
    add_column :video_rails, :deleted_at, :datetime, null: true, default: nil
  end
end
