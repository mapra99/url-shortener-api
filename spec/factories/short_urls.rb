FactoryBot.define do
  factory :short_url do
    original_url { Faker::Internet.url }

    factory :custom_short_url do
      transformed_path { "/#{Faker::Internet.slug}" }
    end
  end
end
