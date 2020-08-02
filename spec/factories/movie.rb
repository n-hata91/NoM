FactoryBot.define do

  factory :movie_tipcorn, class: Movie do
    id { 1 }
    title { Faker::Lorem.characters(number:5) }
    overview { Faker::Lorem.characters(number:400) }
  end

  factory :movie_article, class: Movie do
    id { 2 }
    title { Faker::Lorem.characters(number:5) }
    overview { Faker::Lorem.characters(number:400) }
  end
end