FactoryBot.define do
  factory :book do
    title { 'book title' }
    author { 'valid author' }
    published_in { 2020 }
    volume { 1 }
  end

  factory :random_book, class: Book do
    title { Faker::String.random(length: 3..12) }
    author { Faker::String.random(length: 3..20) }
    published_in { Faker::Number.within(range: 1800..2020) }
    volume { Faker::Number.between(from: 1, to: 10) }
  end

  factory :sequenced_book, class: Book do |n|
    sequence(:title) { |n| "book#{n}"}
    sequence(:author) { |n| "author#{n}"}
    published_in { Faker::Number.within(range: 1800..2020) }
    volume { Faker::Number.between(from: 1, to: 10) }
  end
end
