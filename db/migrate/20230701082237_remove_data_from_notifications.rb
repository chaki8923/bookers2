class RemoveDataFromNotifications < ActiveRecord::Migration[6.1]
  def change
    Notification.delete_all  # 既存のデータを削除する
  end
end
