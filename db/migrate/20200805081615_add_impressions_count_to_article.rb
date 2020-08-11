class AddImpressionsCountToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :pv_counter, :integer, default: 0
  end
end
