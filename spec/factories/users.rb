FactoryBot.define do
  factory :user do
    name { %w[User1 User2 User3].sample }
  end
end
