FactoryBot.define do

  factory :article do
    title { Faker::Lorem.characters(number:50) }
    content { Faker::Lorem.characters(number:400) }
    user
    movie { 2 }
    rate { 3 }
    difficulty { 3 }
    length { 3 }
    practicality { 3 }
    speed { 3 }
    accent { 3 }
  end

  factory :tipcorn, class: Article do
    title { Faker::Lorem.characters(number:50) }
    content { Faker::Lorem.characters(number:400) }
    user
    movie { 1 }
  end
end