class AddUserIdToViewCounts < ActiveRecord::Migration[6.1]
  def change
    add_reference :view_counts, :user, null: true, foreign_key: true
  end
end
