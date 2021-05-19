require 'rails_helper'

RSpec.describe 'without authentication', type: :controller do
  describe BooksController do
    let(:book) { create(:random_book, :skip_validate) }

    it '#index should redirect to user login path' do
      get :index
      expect(response).to be_successful
      get :show, params: { id: book.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end

RSpec.describe '/books with authentication', type: :controller do
  describe BooksController do
    login_user
    it 'should redirect to books path instead of new book path' do
      get :new
      expect(response).to redirect_to(books_path)
    end
  end

  describe BooksController do
    login_admin
    let(:book) { create(:random_book, :skip_validate, title: 'Harry Potter') }

    it 'responds successfully to new book path' do
      get :new
      expect(response).to be_successful
    end

    it 'responds http success for edit request' do
      get :edit, params: { id: book.id }
      expect(response).to have_http_status(200)
    end

    it 'fails to create a new book' do
      stub_api_call('t', true)
      post :create, params: { book: { title: 't', author: 'a',
                                      published_in: 2000, volume: 0 } }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'successfully creates a new book' do
      stub_api_call('The Alchemist', true)
      expect do
        post :create, params: { book: { title: 'The Alchemist', author: 'book author',
                                        published_in: 2000, volume: 2 } }
      end.to change(Book, :count).by(1)
      expect(response).to be_redirect
      expect(response).to have_http_status(302)
    end

    it 'fails to update the book' do
      stub_api_call(book.title, false)
      expect(book.title).to eql('Harry Potter')
      book_id = book.id
      volume = book.volume
      patch :update, params: { book: { volume: 0 }, id: book_id }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Book.find(book_id).volume).to eql(volume)
    end

    it 'updates the book successfully' do
      expect(book.title).to eql('Harry Potter')
      book_id = book.id
      update_title = 'Harry Potter 3'
      stub_api_call(update_title, true)
      patch :update, params: { book: { title: update_title }, id: book.id }
      expect(response).to have_http_status(302)
      expect(response).to be_redirect
      expect(response).to redirect_to(book)
      expect(Book.find(book_id).title).to eql('Harry Potter 3')
    end

    it 'responds to DELETE' do
      delete :destroy, params: { id: book.id }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(books_path)
    end
  end
end
