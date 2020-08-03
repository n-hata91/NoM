FactoryBot.define do

  factory :comment do
    content { 'コメントテストテストテストテストテストテストテストテスト' }
    user
    article
  end

  factory :reply, class: Comment do
    content { 'リプライテストテストテストテストテストテストテスト' }
    user
    comment
  end
end