require 'rails_helper'

RSpec.describe '/books', type: :request do
  let(:valid_attributes) do
    {
      'id' => '1',
      'title' => 'book title',
      'author' => 'book author',
      'published_in' => 2000,
      'volume' => 1
    }
  end

  let(:invalid_attributes) do
    {
      'id' => 'x',
      'title' => '',
      'author' => 'a',
      'published_in' => 2333,
      'volume' => 0
    }
  end

  describe 'GET /index' do
    let(:book) { build(:book) }
    it 'renders a successful response' do
      book.save
      get books_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    let(:book) { build(:book) }
    it 'renders a successful response for show page' do
      # book = Book.new(valid_attributes)
      book.save
      get books_url(book)
      expect(response).to be_successful
    end
  end
end

RSpec.describe '/books with authentication' do
  # before(:each) do
  #   user = User.new(email: 'admin@example.com', password: 'secret')
  #   user.admin = true
  #   user.save!
  #   session[:user_id] = 1
  # end

  # describe 'GET /new' do
  #   it 'responds successfully to new book path' do
  #     session['user_id'] = 1
  #     get new_book_path
  #     expect(response).to be_successful
  #   end
  # end
end
