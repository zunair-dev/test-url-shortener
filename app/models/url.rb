class Url < ApplicationRecord
  validates :original_url, :short_url, presence: true

  before_validation :original_url_format, on: :create
  before_validation :generate_short_url, on: :create

  def increment_visits!
    update(visits_count: visits_count + 1)
  end

  private

  def generate_short_url
    self.short_url = UrlShortener.generate_short_url
  end

  def original_url_format
    uri = URI.parse(original_url)
    errors.add(:original_url, "is not a valid URL") unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue URI::InvalidURIError
    errors.add(:original_url, "is not a valid URL")
  end
end
