class AddForeignKeyToFavorites < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :favorites, :users
    add_foreign_key :favorites, :books
  end
end
