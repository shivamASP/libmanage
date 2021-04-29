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
         subject: "Congrats! Book #{@book.title} successfully issued"
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
         subject: "Congrats! Book #{@book.title} successfully returned"
  end

  def reminder(bookissues)
    bookissues.each do |bookissue|
      @book = Book.find(bookissue.book_id)
      @user = User.find(bookissue.user_id)

      mail to: @user.email,
           subject: "Reminder Email to return #{@book.title}"
    end
  end
end
