require 'rails_helper'

RSpec.describe '/books', type: :request do
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
      book.save
      get books_url(book)
      expect(response).to be_successful
    end
  end
end
