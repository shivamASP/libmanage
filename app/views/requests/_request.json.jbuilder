json.extract! request, :id, :title, :author, :published_in, :volume, :created_at, :updated_at
json.url request_url(request, format: :json)
