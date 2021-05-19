require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validation tests using static' do
    let(:book) { build(:book) }

    before do
      stub_api_call(book.title, true)
    end

    it 'succeeds for title present' do
      expect(book.save).to eq(true)
    end

    it 'fails for title absent' do
      book.title = nil
      stub_api_call(book.title, true)
      expect(book.save).to eq(false)
    end

    it 'validates author length' do
      book.author = 'a'
      expect(book).not_to be_valid
      book.author = 'auth'
      expect(book).to be_valid
    end
  end

  describe 'validates using Faker' do
    let(:book) { build(:random_book) }

    before do
      stub_api_call(book.title, true)
    end

    it 'validates title length' do
      book.title = 't'
      stub_api_call(book.title, true)
      expect(book.save).to eq(false)
    end

    it 'validates title absence' do
      book.title = nil
      stub_api_call(book.title, true)
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

  describe 'issue and return logic' do
    let(:book) { create(:random_book, :skip_validate) }
    let(:user) { create(:random_user) }
    it 'checks the availability count of book after issue' do
      issuedbook = Book.issuelogic({ id: book.id, format: 'issue' }, user.id)
      expect(issuedbook.availability).to eql(4)
    end

    it 'checks the availability count of book after return' do
      issuedbook = Book.issuelogic({ id: book.id, format: 'issue' }, user.id)
      returnedbook = Book.returnlogic({ id: issuedbook.id, format: 'return' }, user.id)
      expect(returnedbook.availability).to eql(5)
    end
  end
end
