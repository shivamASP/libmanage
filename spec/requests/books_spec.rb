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
    it 'renders a successful response' do
      get books_url
      expect(response).to be_successful
    end
  end
end
