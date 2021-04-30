FactoryBot.define do
  factory :random_user, class: User do
    email { Faker::Internet.safe_email }
    password { Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3, min_numeric: 3) }
    trait :admin do
      admin { true }
    end
  end
end
