class UrlSerializer < ActiveModel::Serializer
  attributes :id, :original_url, :short_url, :visits_count, :created_at

  # Include the full URL for the shortened link
  attribute :short_url_path do
    Rails.application.routes.url_helpers.short_url(object.short_url, host: ENV["HOST_URL"])
  end
end
