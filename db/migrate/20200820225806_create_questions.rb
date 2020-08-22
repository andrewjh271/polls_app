class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.text :text, null: false
      t.integer :poll_id, null:false, index: true
      t.timestamps
    end
  end
end
