class RemoveGroupUserIdsFromGroups < ActiveRecord::Migration[6.1]
  def change
    remove_column :groups, :group_id, :integer
    remove_column :groups, :user_id, :integer
    add_column :groups, :image_id, :string
  end
end
