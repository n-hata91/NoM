FactoryBot.define do

  factory :comment do
    content { Faker::Lorem.characters(number:140) }
    user
    article
  end

  factory :reply, class: Comment do
    content { Faker::Lorem.characters(number:140) }
    user
    comment
  end
end