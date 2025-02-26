FactoryBot.define do
  factory :url do
    original_url { "MyText" }
    short_url { "MyString" }
    visits_count { 1 }
  end
end
