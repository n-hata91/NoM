class Article < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :replies, class_name: "Comment", foreign_key: "reply_to", dependent: :destroy
  has_many :article_tags, dependent: :destroy

  def favorited?(user)
    favorites.where(user_id: user.id).exists?
  end
  
end
