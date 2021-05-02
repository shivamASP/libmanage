require 'rails_helper'

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
    let(:book) { create(:book) }

    it 'responds successfully to new book path' do
      get :new
      expect(response).to be_successful
    end

    it 'responds http success for edit request' do
      get :edit, params: { id: book.id }
      expect(response).to have_http_status(200)
    end

    it 'successfully creates a new book' do
      expect do
        post :create, params: { book: { title: 'booktitle', author: 'bookauthor',
                                        published_in: 2000, volume: 2 } }
      end.to change(Book, :count).by(1)
      expect(response).to be_redirect
      expect(response).to have_http_status(302)
    end

    let(:another_book) { create(:random_book, title: 'to be updated') }
    it 'updates the book successfully' do
      expect(another_book.title).to eql('to be updated')
      book_id = another_book.id
      patch :update, params: { book: { title: 'updated title' }, id: another_book.id }
      expect(response).to have_http_status(302)
      expect(response).to be_redirect
      expect(response).to redirect_to(another_book)
      expect(Book.find(book_id).title).to eql('updated title')
    end

    it 'responds to DELETE' do
      delete :destroy, params: { id: book.id}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(books_path)
    end
  end
end
