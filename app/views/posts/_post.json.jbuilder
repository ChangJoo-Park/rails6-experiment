# frozen_string_literal: true

json.extract! post, :id, :title, :content, :published, :published_at, :created_at, :updated_at
json.url post_url(post, format: :json)
