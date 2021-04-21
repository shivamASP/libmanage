require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validation tests using static' do
    let(:book) { build(:book)}
    # let(:book) { create(:book)}
    it 'validates title presence' do
      expect(book.save).to eq(true)
    end
    it 'checks for title absence' do
      book.title = nil
      expect(book.save).to eq(false)
    end

    it 'validates author length' do
      book.author = 'a'
      expect(book).not_to be_valid
      book.author = 'auth'
      expect(book).to be_valid
      book.author = 'asdlseuifsdfjhsdfjasoifuhasfjk'
      expect(book).not_to be_valid
    end
  end

  describe 'validates using Faker' do
    let(:book) { build(:random_book)}

    it 'validates title length' do
      book.title = 't'
      expect(book.save).to eq(false)
    end
    it 'validates title absence' do
      book.title = nil
      expect(book.save).to eq(false)
    end

    it 'validates published_in value' do
      book.published_in = 1700
      expect(book).not_to be_valid

      book.published_in = 2010
      expect(book).to be_valid

      book.published_in = 2022
      expect(book).not_to be_valid
    end

    it 'validates for volume' do
      book.volume = nil
      expect(book).to be_valid

      book.volume = 0
      expect(book).not_to be_valid
    end
  end
end

  # it 'has an invalid title' do
  #   book = Book.new(
  #     title: '',
  #     author: 'book author',
  #     published_in: 2020,
  #     volume: 1
  #   )
  #   expect(book).not_to be_valid
  # end

  # it 'has a valid title' do
  #   book = Book.new(
  #     title: 'title',
  #     author: 'book author',
  #     published_in: 2020,
  #     volume: 1
  #   )
  #   expect(book).to be_valid
  # end

  # it 'has nil author' do
  #   book = Book.new(
  #     title: 'title',
  #     author: '',
  #     published_in: 2020,
  #     volume: 1
  #   )
  #   expect(book).not_to be_valid
  # end

  # it 'has author length less than minimum' do
  #   book = Book.new(
  #     title: 'title',
  #     author: 'a',
  #     published_in: 2020,
  #     volume: 1
  #   )
  #   expect(book).not_to be_valid
  # end

  # it 'has author length greater than maximum' do
  #   book = Book.new(
  #     title: 'title',
  #     author: 'aeiurlkaejfraoeifaklsdmfnaoirfajn',
  #     published_in: 2020,
  #     volume: 1
  #   )
  #   expect(book).not_to be_valid
  # end

  # it 'has author with valid length' do
  #   book = Book.new(
  #     title: 'title',
  #     author: 'valid author',
  #     published_in: 2020,
  #     volume: 1
  #   )
  #   expect(book).to be_valid
  # end

  # it 'has nil published in' do
  #   book = Book.new(
  #     title: 'title',
  #     author: 'valid author',
  #     published_in: nil,
  #     volume: 1
  #   )
  #   expect(book).to be_valid
  # end

  # it 'has published in less than 1800' do
  #   book = Book.new(
  #     title: 'title',
  #     author: 'valid author',
  #     published_in: 1700,
  #     volume: 1
  #   )
  #   expect(book).not_to be_valid
  # end

  # it 'has published in greater than 2020' do
  #   book = Book.new(
  #     title: 'title',
  #     author: 'valid author',
  #     published_in: 2222,
  #     volume: 1
  #   )
  #   expect(book).not_to be_valid
  # end

  # it 'has a valid published in' do
  #   book = Book.new(
  #     title: 'title',
  #     author: 'valid author',
  #     published_in: 2000,
  #     volume: 1
  #   )
  #   expect(book).to be_valid
  # end

  # it 'has nil volume' do
  #   book = Book.new(
  #     title: 'title',
  #     author: 'valid author',
  #     published_in: 2020,
  #     volume: nil
  #   )
  #   expect(book).to be_valid
  # end

  # it 'has volume less than 1' do
  #   book = Book.new(
  #     title: 'title',
  #     author: 'valid author',
  #     published_in: 2020,
  #     volume: 0
  #   )
  #   expect(book).not_to be_valid
  # end

  # it 'has a valid volume' do
  #   book = Book.new(
  #     title: 'title',
  #     author: 'valid author',
  #     published_in: 2020,
  #     volume: 2
  #   )
  #   expect(book).to be_valid
  # end
