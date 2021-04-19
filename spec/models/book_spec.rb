require 'rails_helper'

RSpec.describe Book, type: :model do

  it 'has an invalid title' do
    book = Book.new(
      title: '',
      author: 'book author',
      published_in: 2020,
      volume: 1
    )
    expect(book).not_to be_valid
  end

  it 'has a valid title' do
    book = Book.new(
      title: 'title',
      author: 'book author',
      published_in: 2020,
      volume: 1
    )
    expect(book).to be_valid
  end

  it 'has nil author' do
    book = Book.new(
      title: 'title',
      author: '',
      published_in: 2020,
      volume: 1
    )
    expect(book).not_to be_valid
  end

  it 'has author length less than minimum' do
    book = Book.new(
      title: 'title',
      author: 'a',
      published_in: 2020,
      volume: 1
    )
    expect(book).not_to be_valid
  end

  it 'has author length greater than maximum' do
    book = Book.new(
      title: 'title',
      author: 'aeiurlkaejfraoeifaklsdmfnaoirfajn',
      published_in: 2020,
      volume: 1
    )
    expect(book).not_to be_valid
  end

  it 'has author with valid length' do
    book = Book.new(
      title: 'title',
      author: 'valid author',
      published_in: 2020,
      volume: 1
    )
    expect(book).to be_valid
  end

  it 'has nil published in' do
    book = Book.new(
      title: 'title',
      author: 'valid author',
      published_in: nil,
      volume: 1
    )
    expect(book).to be_valid
  end

  it 'has published in less than 1800' do
    book = Book.new(
      title: 'title',
      author: 'valid author',
      published_in: 1700,
      volume: 1
    )
    expect(book).not_to be_valid
  end

  it 'has published in greater than 2020' do
    book = Book.new(
      title: 'title',
      author: 'valid author',
      published_in: 2222,
      volume: 1
    )
    expect(book).not_to be_valid
  end

  it 'has a valid published in' do
    book = Book.new(
      title: 'title',
      author: 'valid author',
      published_in: 2000,
      volume: 1
    )
    expect(book).to be_valid
  end

  it 'has nil volume' do
    book = Book.new(
      title: 'title',
      author: 'valid author',
      published_in: 2020,
      volume: nil
    )
    expect(book).to be_valid
  end

  it 'has volume less than 1' do
    book = Book.new(
      title: 'title',
      author: 'valid author',
      published_in: 2020,
      volume: 0
    )
    expect(book).not_to be_valid
  end

  it 'has a valid volume' do
    book = Book.new(
      title: 'title',
      author: 'valid author',
      published_in: 2020,
      volume: 2
    )
    expect(book).to be_valid
  end
end
