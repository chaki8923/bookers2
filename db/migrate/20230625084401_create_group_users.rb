create_table :group_users, id: false do |t|
  t.references :group, null: false, foreign_key: true
  t.references :user, null: false, foreign_key: true
  t.timestamps
end
add_index :group_users, [:group_id, :user_id], unique: true