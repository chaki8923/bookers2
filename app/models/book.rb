class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :view_counts, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def total_favorites_last_week
    favorites.where(created_at: 1.week.ago..Time.current).count
  end
  
  def safe_view_count
    view_counts.first&.count || 0
  end
  
end
