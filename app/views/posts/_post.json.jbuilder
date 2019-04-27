json.extract! post, :id, :title, :content, :published, :published_at, :slug, :created_at, :updated_at
json.url post_url(post, format: :json)
