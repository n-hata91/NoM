class RenamePvCounterColumnToArticles < ActiveRecord::Migration[5.2]
  def change
    rename_column :articles, :pv_counter, :impressions_count
  end
end
