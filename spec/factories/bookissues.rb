FactoryBot.define do
  factory :bookissue do
    association :user, factory: :random_user
    association :book, factory: %i[random_book skip_validate]
  end
end
