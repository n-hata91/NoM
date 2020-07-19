class Movie < ApplicationRecord
  has_many :articles, dependent: :destroy
end
