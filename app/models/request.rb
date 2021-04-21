class Request < ApplicationRecord
  validates :title, length: { minimum: 2 }, presence: true
  validates :author, length: { minimum: 2, maximum: 20 }, presence: true
  validates :published_in, numericality: {less_than_or_equal_to: 2020, greater_than_or_equal_to: 1800, allow_nil: true}
  validates :volume, numericality: {greater_than_or_equal_to: 1, allow_nil: true}

  belongs_to :user
end
