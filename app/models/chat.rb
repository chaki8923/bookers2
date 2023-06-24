class Chat < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  
  validates :message, presence: true
  
  scope :between, ->(sender_id, receiver_id) do
    where("(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)",
          sender_id, receiver_id, receiver_id, sender_id)
  end

end
