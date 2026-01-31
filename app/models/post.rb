class Post < ApplicationRecord
  belongs_to :user
  has_many :media, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :content, presence: true, length: { maximum: 5000 }
   def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end
