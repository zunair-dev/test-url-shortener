FactoryBot.define do
  factory :url do
    original_url { Faker::Internet.url }
    short_url { SecureRandom.alphanumeric(8) }
    visits_count { 0 }  # setting default value to 0
  end
end
