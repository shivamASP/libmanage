# Preview all emails at http://localhost:3000/rails/mailers/library_mailer
class LibraryMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/library_mailer/issue
  def issue
    bookissue = Bookissue.last
    LibraryMailer.issue(bookissue)
  end

  # Preview this email at http://localhost:3000/rails/mailers/library_mailer/return
  def return
    bookissue = Bookissue.last
    LibraryMailer.return(bookissue)
  end

end
