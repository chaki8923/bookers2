class AddForeignKeyToBookComments < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :book_comments, users
    remove_foreign_key :book_comments, books
  end
end
