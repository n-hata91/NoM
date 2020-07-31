class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: {maximum: 15}
  has_many :article_tags, dependent: :destroy
  has_many :articles, dependent: :destroy
end
