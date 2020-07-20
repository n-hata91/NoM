class Relation < ApplicationRecord
  has_many :follow_to, class_name: "Relation",
                        foreign_key: "follower_id",
                        dependent: :destroy
  has_many :follow_from, class_name: "Relation",
                        foreign_key: "followed_id",
                        dependent: :destroy
  has_many :following, through: :follow_to, source: :followed
  has_many :followers, through: :follow_from, source: :follower
end
