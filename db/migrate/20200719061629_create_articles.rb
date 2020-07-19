class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.references :user, foreign_key: true, null: false
      t.references :movie, foreign_key: true
      t.string :title, null: false
      t.text :content, null: false
      t.string :image_id
      t.integer :rate, default: 3
      t.integer :difficulty, default: 3
      t.integer :length, default: 3
      t.integer :practicality, default: 3
      t.integer :speed, default: 3
      t.integer :accent, default: 3

      t.timestamps
    end
  end
end
