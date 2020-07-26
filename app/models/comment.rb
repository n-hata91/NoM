class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  has_many :replies, class_name: "Comment", foreign_key: "reply_to", dependent: :destroy
end
