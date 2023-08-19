class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books,  dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  # フォローされる側関連付け
  has_many :followed_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  # followed_relationships経由でfollowerと多対多の関係
  has_many :followers, through: :followed_relationships, source: :follower
  
  
  
  # フォローする側関連付け
  has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  # follower_relationships経由でfollowedと多対多の関係
  has_many :followings, through: :follower_relationships, source: :followed
  
  
  
  
  has_many :group_users
  has_many :groups, through: :group_users


  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}

  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  def follow(user)
    follower_relationships.create(followed: user)
  end
  
  def unfollow(user)
    follower_relationships.find_by(followed: user).destroy
  end
  
  def following?(user)
    followings.include?(user)
  end

    
  def post_books_count(user_id, day)
    user = User.find(user_id)
    today = Date.today

    case day
      when 'today'
        user.books.where("DATE(created_at) = ?", today).count
      when 'yesterday'
        user.books.where("DATE(created_at) = ?", today - 1.day).count
      when 'this_week'
        start_of_this_week = today.beginning_of_week
        end_of_this_week = today.end_of_week
        user.books.where("DATE(created_at) >= ? AND DATE(created_at) <= ?", start_of_this_week, end_of_this_week).count
      when 'last_week'
        start_of_last_week = (today - 1.week).beginning_of_week
        end_of_last_week = (today - 1.week).end_of_week
        
        user.books.where("DATE(created_at) >= ? AND DATE(created_at) <= ?", start_of_last_week, end_of_last_week).count
    end
    
  end
  
  def week_day_count(user_id, n)
    user = User.find(user_id)
    user.books.where("DATE(created_at) = ?", Date.today - n.day).count
  end
end
