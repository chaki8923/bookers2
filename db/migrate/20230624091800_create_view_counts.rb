class CreateViewCounts < ActiveRecord::Migration[6.1]
  def change
    create_table :view_counts do |t|
       t.references :book, null: false
       t.integer :count, default: 0

      t.timestamps
    end
  end
end
