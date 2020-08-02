
FactoryBot.define do

  factory :language do
    language { Faker::Lorem.characters(number:5) }
  end
end