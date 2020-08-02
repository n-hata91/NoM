FactoryBot.define do
  factory :tag do
    name { Faker::Lorem.characters(number:20) }
  end
end