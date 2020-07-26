class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.text :overview
      t.string :image_id

      t.timestamps
    end
  end
end
