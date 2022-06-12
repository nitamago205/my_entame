FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number:20) }
    body { Faker::Lorem.characters(number:100) }
    genre_id { "1" }
    rate { "3.0" }
    user
  end
end