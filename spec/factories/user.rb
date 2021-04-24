FactoryBot.define do
  factory :random_user, class: User do
    email { 'user@example.com' }
    password { '123456' }
  end
end