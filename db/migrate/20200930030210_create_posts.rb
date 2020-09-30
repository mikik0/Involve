class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string "title"
      t.string "introduction"
      t.integer "user_id"
      t.integer "category_id"
      t.date "due_date"
      t.timestamps null: false
    end
  end
end
