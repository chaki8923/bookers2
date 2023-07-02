class RemoveForeignKeys < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :book_comments, :users
    remove_foreign_key :book_comments, :books
    remove_foreign_key :favorites, :books
    remove_foreign_key :favorites, :users
    remove_foreign_key :view_counts, :books
    remove_foreign_key :view_counts, :users
  end
end
