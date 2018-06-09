class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.text :uid
      t.integer :auth_type
      t.string :name
      t.string :nickname

      t.timestamps
    end
  end
end
