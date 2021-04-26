class Book < ApplicationRecord
  validates :title, length: { minimum: 2 }, presence: true
  validates :author, length: { minimum: 2, maximum: 20 }, presence: true
  validates :published_in,
            numericality: { less_than_or_equal_to: 2020, greater_than_or_equal_to: 1800, allow_nil: true }
  validates :volume, numericality: { greater_than_or_equal_to: 1, allow_nil: true }

  def self.issuelogic(params, uid)
    book_id = params[:id]
    actiontype = params[:format]
    @book = Book.find(book_id)
    @issued = Bookissue.find_by({ user_id: uid, book_id: @book.id })

    if @issued.blank?
      @issue_data = Bookissue.new({ user_id: uid, book_id: @book.id })
      @issue_data.save
      LibraryMailer.issue(@issue_data).deliver_later
      @book.decrement!(:availability) if actiontype == 'issue'
    end
    @book
  end

  def self.returnlogic(params, uid)
    book_id = params[:id]
    actiontype = params[:format]
    @book = Book.find(book_id)
    @issue_data = Bookissue.find_by({ user_id: uid, book_id: @book.id })
    if @issue_data.present? && (actiontype == 'return')
      @book.increment!(:availability)
      LibraryMailer.return(@issue_data).deliver_later
      @issue_data.destroy
    end
    @book
  end
  has_many :bookissue, dependent: :destroy
end
