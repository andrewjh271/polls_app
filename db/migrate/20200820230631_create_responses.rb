class CreateResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :responses do |t|
      t.integer :user_id, null: false, index: true
      t.integer :answer_choice_id, null: false, index: true
      t.timestamps
    end
    add_index :responses, %i(user_id answer_choice_id), unique: true
  end
end
