class LibraryMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.library_mailer.issue.subject
  #
  def issue(bookissue)
    @book = bookissue.book
    @user = bookissue.user

    mail to: @user.email,
         subject: "Congrats! Book #{@book.title} successfully issued"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.library_mailer.return.subject
  #
  def return(book, user)
    @book = book
    @user = user

    mail to: @user.email,
         subject: "Congrats! Book #{@book.title} successfully returned"
  end
end
