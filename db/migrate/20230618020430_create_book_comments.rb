class CreateBookComments < ActiveRecord::Migration[6.1]
  def change
    create_table :book_comments do |t|
      t.text :comment
      t.bigint :user_id
      t.bigint :book_id

      t.timestamps
    end
    add_foreign_key :book_comments, :users
    add_foreign_key :book_comments, :books
  end
end
