require 'rails_helper'

RSpec.describe LibraryMailer, type: :mailer do
  describe 'issue' do
    let(:bookissue) { create(:bookissue) }
    let(:mail) { LibraryMailer.issue(bookissue) }

    it 'renders the headers' do
      book = Book.find(bookissue.book_id)
      user = User.find(bookissue.user_id)
      expect(mail.subject).to eq("Congrats! Book #{book.title} successfully issued")
      expect(mail.to).to eq([user.email.to_s])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      user = User.find(bookissue.user_id)
      expect(mail.body.encoded).to match("Hi! #{user.email}")
    end
  end
end
