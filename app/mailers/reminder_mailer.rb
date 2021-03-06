class ReminderMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reminder_mailer.reminder.subject
  #
  def reminder(bookissue)
    @bookissue = bookissue
    @book = bookissue.book
    @user = bookissue.user
    mail to: @user.email,
         subject: "Reminder to return #{@book.title}"
  end
end
