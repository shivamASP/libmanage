FactoryBot.define do
  factory :bookissue do
    association :user, factory: :random_user
    association :book, factory: :random_book
  end
end
