class Book < ApplicationRecord
  validates :title, length: { minimum: 2, maximum: 50 }, presence: true
  validates :author, length: { minimum: 2, maximum: 50 }, presence: true
  validates :published_in,
            numericality: { less_than_or_equal_to: 2020, greater_than_or_equal_to: 1800, allow_nil: true }
  validates :volume, numericality: { greater_than_or_equal_to: 1, allow_nil: true }
  validate :validate_book

  def self.issuelogic(params, uid)
    book_id = params[:id]
    actiontype = params[:format]
    @book = Book.find(book_id)
    unless @book.availability.zero?
      @issued = Bookissue.find_by({ user_id: uid, book_id: @book.id })
      if @issued.blank?
        @issue_data = Bookissue.new({ user_id: uid, book_id: @book.id })
        @issue_data.save
        LibraryMailer.issue(@issue_data).deliver_later
        @book.decrement!(:availability) if actiontype == 'issue'
      end
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
      @user = User.find(uid)
      ReturnMailerJob.perform(@book, @user)
      @issue_data.destroy
    end
    @book
  end
  has_many :bookissue, dependent: :destroy

  private

  def validate_book
    search_keyword = title.to_s.tr(' ', '+')
    url = "https://www.googleapis.com/books/v1/volumes?q=intitle:#{search_keyword}&key=AIzaSyDTwKE17DDbFVAOQl2OMyq-TlUFXDv56nY"
    uri = URI(url)
    api_response = Net::HTTP.get(uri)
    return if api_response.include? title.to_s

    errors.add(:base, 'It\'s not a valid book')
  end
end
