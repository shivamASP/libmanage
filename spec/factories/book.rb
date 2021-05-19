FactoryBot.define do
  factory :book do
    title { 'book title' }
    author { 'valid author' }
    published_in { 2020 }
    volume { 1 }
    transient do
      availability { 0 }
    end
    after :create, :build do |book, evaluator|
      book.availability = evaluator.availability
    end
  end

  factory :random_book, class: Book do
    title { Faker::Book.title }
    author { Faker::Alphanumeric.alpha(number: 10) }
    published_in { Faker::Number.within(range: 1800..2020) }
    volume { Faker::Number.between(from: 1, to: 10) }
    trait :skip_validate do
      to_create { |instance| instance.save(validate: false) }
    end
  end

  factory :sequenced_book, class: Book do |n|
    sequence(:title) { |n| "book#{n}"}
    sequence(:author) { |n| "author#{n}"}
    published_in { Faker::Number.within(range: 1800..2020) }
    volume { Faker::Number.between(from: 1, to: 10) }
  end
end
