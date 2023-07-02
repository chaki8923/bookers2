class Notification < ApplicationRecord
  
  belongs_to :group
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
end
