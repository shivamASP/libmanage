json.extract! book, :id, :title, :author, :published_in, :volume, :created_at, :updated_at
json.url book_url(book, format: :json)
