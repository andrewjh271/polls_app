class CreatePolls < ActiveRecord::Migration[5.2]
  def change
    create_table :polls do |t|
      t.string :title, null: false, unique: true
      t.integer :user_id, null: false, index: true
      t.timestamps
    end
  end
end
