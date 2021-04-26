class LibraryMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.library_mailer.issue.subject
  #
  def issue(bookissue)
    @book = Book.find(bookissue.book_id)
    @user = User.find(bookissue.user_id)

    mail to: @user.email,
         subject: 'Congrats! Book successfully issued'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.library_mailer.return.subject
  #
  def return(bookissue)
    @book = Book.find(bookissue.book_id)
    @user = User.find(bookissue.user_id)

    mail to: @user.email,
         subject: 'Congrats! Book successfully returned'
  end
end
