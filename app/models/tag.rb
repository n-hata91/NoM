class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: {maximum: 20}
  has_many :articles, dependent: :destroy
  has_many :article_tags, dependent: :destroy
  has_many :articles, through: :article_tags, source: :article
end
