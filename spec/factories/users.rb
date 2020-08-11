FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number:15) }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number:140) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end