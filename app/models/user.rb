class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  # フォローする側関連付け
  has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  # フォローされる側関連付け
  has_many :followed_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  
  # follower_relationships経由でfollowedと多対多の関係
  has_many :followings, through: :follower_relationships, source: :followed
  # followed_relationships経由でfollowerと多対多の関係
  has_many :followers, through: :followed_relationships, source: :follower


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
end
