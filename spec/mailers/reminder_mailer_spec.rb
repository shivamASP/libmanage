require 'rails_helper'

RSpec.describe ReminderMailer, type: :mailer do
  describe 'reminder' do
    let(:bookissue) { create(:bookissue) }
    let(:mail) { ReminderMailer.reminder(bookissue) }
    it 'renders the headers' do
      book = bookissue.book
      user = bookissue.user
      expect(mail.subject).to eq("Reminder to return #{book.title}")
      expect(mail.to).to eq([user.email.to_s])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      book = Book.find(bookissue.book_id)
      expect(mail.body.encoded).to match("#{book.title} was issued to your id on #{bookissue.created_at.to_date}")
    end
  end
end
